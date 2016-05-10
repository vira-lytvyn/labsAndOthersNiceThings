#pragma once

//родитель для элементов, которые можно сохранять в стек DO/UNDO
//(нужно произвести свои элементы от этой структуры)
struct sDoUndo2_item
{
	//скопировать данные из *pCopyFromITEM_in в *this
	//(используется в CDoUndo2::s_stack)
	virtual void sDU2i_CopyToThisFrom(const sDoUndo2_item* pCopyFromITEM_in)=0;

	//используется для вызова new производной структуры
	//(в CDoUndo2::s_stack используется в качестве new для производной структуры)
	virtual sDoUndo2_item* sDU2i_NewObject() const =0;

	//используется для вызова delete производной структуры
	//(в CDoUndo2::s_stack используется в качестве delete для производной структуры)
	virtual void sDU2i_DeleteThis() const =0;
};

/*
//ТИПИЧНОЕ ОПРЕДЕЛЕНИЕ СТРУКТУРЫ ПРОИЗВОДНОГО ЭЛЕМЕНТА sChildItem:

struct sChildItem:public sDoUndo2_item
{
	//хранимые данные
	<type> m_var1;
	<type> m_var2;
	...
	...

	//виртуальные
	virtual void sDU2i_CopyToThisFrom(const sDoUndo2_item* pCopyFromITEM_in)=0;
	{
		//копируем
		*this=*(sChildItem*)pCopyFromITEM_in;

		//(ИЛИ делаем почленное копирование)
		//m_var1=pCopyFromITEM_in->m_var1;
		//m_var2=pCopyFromITEM_in->m_var2;
		//...
		//...
	}

	virtual sDoUndo2_item* sDU2i_NewObject() const
	{
		return new sChildItem;
	}

	virtual void sDU2i_DeleteThis() const
	{
		delete this;
	}
}
*/


class CDoUndo2
{
	enum
	{
		e_minStSize	=	10,	//минимальный размер стека
		e_maxStSize	=	100,//максимольный размер стека
	};

	//структура стека
	struct s_stack
	{
		private:
		sDoUndo2_item**	m_pStack;		//стек
		int				m_nSize;		//размер стека в элементах.
		int				m_nNumFilled;	//счётчик элементов в стеке

		public:

		s_stack()
		{
			memset(this,0,sizeof(*this));
		}

		int GetFilledNum()
		{
			return m_nNumFilled;
		}

		//стек пуст ?
		bool IsEmpty()
		{
			return !m_nNumFilled;
		}

		//создание стека
		void NewStack(int nSize)
		{
			if(!m_pStack && nSize>0)
			{
				m_pStack=new sDoUndo2_item* [m_nSize=nSize];//массив указателей
				memset(m_pStack,0,sizeof(*m_pStack)*m_nSize);
				m_nNumFilled=0;
			}
		}

		//удаление стека
		void DeleteStack()
		{
			ClearStack();


			if(m_pStack)	delete [] m_pStack;//удаляем массив указателей
			m_pStack=0;
			m_nSize=0;
			m_nNumFilled=0;
		}

		//проверяем, что стек создан
		bool IsValid()
		{
			return (m_pStack && m_nSize>0);
		}

		//очистка стека
		void ClearStack()
		{
			if(m_pStack)
			{
				for(int i=0;i<m_nNumFilled;i++)
				{
					if(m_pStack[i])
					{
						m_pStack[i]->sDU2i_DeleteThis();//delete m_pStack[i];
						m_pStack[i]=0;
					}
				}
			}
			m_nNumFilled=0;
		}

		//поместить элемент в стек
		void Push(const sDoUndo2_item* pITEM_toCopyFrom_in)
		{
			//если стек заполнен до упора, то сдвигаем
			//содержимое стека на единицу по принципу FIFO,
			//убивая самый ранний элемент
			if(m_nNumFilled==m_nSize)
			{
				//удаляем первый элемент
				if(m_pStack[0])
				{
					m_pStack[0]->sDU2i_DeleteThis();//delete m_pStack[0];
				}

				//сдвигаем остальные элементы стека
				//и уменьшаем указатель
				for(int i=1;i<m_nSize;i++)
				{m_pStack[i-1]=m_pStack[i];}
				m_nNumFilled--;
			}

			//добавляем элемент и увеличиваем указатель
			sDoUndo2_item* pNew=pITEM_toCopyFrom_in->sDU2i_NewObject();//sDoUndo2_item* pNew=new sDoUndo2_item;
			if(pNew)
			{
				pNew->sDU2i_CopyToThisFrom(pITEM_toCopyFrom_in);
				m_pStack[m_nNumFilled]=pNew;
				m_nNumFilled++;
			}

		}

		//извлечь элемент из стека
		bool Pop(sDoUndo2_item* const pITEM_toCopyTo_out)
		{
			//если элементов нет, то выходим
			if(m_nNumFilled==0)return false;
			//уменьшаем указатель и извлекаем элемент

			m_nNumFilled--;
			pITEM_toCopyTo_out->sDU2i_CopyToThisFrom(m_pStack[m_nNumFilled]);

			//удаляем элемент из стека
			m_pStack[m_nNumFilled]->sDU2i_DeleteThis();//	delete m_pStack[m_nNumFilled];
			return true;
		}
	};

	//////////////////////////////////////////////////
private:

	s_stack m_UndoStack;//стек UNDO
	s_stack m_DoStack;//стек DO
	//////////////////////////////////////////////////
private:
	void DeleteAllStacks();
	void PushToDo(const sDoUndo2_item* const pITEM_toCopyFrom_in);
	bool PopFromDo(sDoUndo2_item* const pITEM_toCopyTo_out);	
	void PushToUndo(const sDoUndo2_item* const pITEM_toCopyFrom_in);
	bool PopFromUndo(sDoUndo2_item* const pITEM_toCopyTo_out);
	//////////////////////////////////////////////////

public:
	CDoUndo2(int UNDO_size=0,int DO_size=0);
	~CDoUndo2();

	//////////////////////////////////////////////////
	//интерфейс
public:
	bool SetStacksSizez(int UNDO_size,int DO_size);
	int GetDoFilledNum();
	int GetUndoFilledNum();
	void SaveItemBeforeNewAction(const sDoUndo2_item* const pITEM_in);
	bool OperationDo(sDoUndo2_item* const pITEM_in_out);
	bool OperationUndo(sDoUndo2_item* const pITEM_in_out);
};

