#include "stdafx.h"	//для пишущих в среде VC++6 с использованием прекомпилированных файлов. Иначе - заремарить

//----------

#include "DoUndo2.h"

//конструктор
CDoUndo2::CDoUndo2(int UNDO_size,int DO_size)
{
	SetStacksSizez(UNDO_size,DO_size);
}

//деструктор
CDoUndo2::~CDoUndo2()
{
	DeleteAllStacks();
}

//задать глубину стеков. Предыдущее содержимое стеков удаляется
bool CDoUndo2::SetStacksSizez(int UNDO_size,int DO_size)
{
	DeleteAllStacks();

	//задание размеров стеков UNDO и DO
	UNDO_size	=max(e_minStSize,min(e_maxStSize,UNDO_size	));
	DO_size		=max(e_minStSize,min(e_maxStSize,DO_size	));

	//создаём стеки
	m_UndoStack.NewStack(UNDO_size);
	m_DoStack.	NewStack(DO_size);

	if(m_UndoStack.IsValid() && m_DoStack.IsValid())
	{
		return true;
	}

	//чёта не вышло )
	DeleteAllStacks();
	return false;
}

void CDoUndo2::DeleteAllStacks()
{
	//удаляем стеки
	m_UndoStack.DeleteStack();
	m_DoStack.DeleteStack();
}


//добавление элемента в UNDO_Stack
//в стеке сохраняется не указатель, а копия элемента
void CDoUndo2::PushToUndo(const sDoUndo2_item* const pITEM_toCopyFrom_in)
{
	m_UndoStack.Push(pITEM_toCopyFrom_in);
}

// добавление элемента в DO_Stack
//в стеке сохраняется не указатель, а копия элемента
void CDoUndo2::PushToDo(const sDoUndo2_item* const pITEM_toCopyFrom_in)
{
	m_DoStack.Push(pITEM_toCopyFrom_in);
}

//функция извлечения из Undo стека
bool CDoUndo2::PopFromUndo(sDoUndo2_item* const pITEM_toCopyTo_out)
{
	return m_UndoStack.Pop(pITEM_toCopyTo_out);
}

//функция извлечения из Do стека
bool CDoUndo2::PopFromDo(sDoUndo2_item* const pITEM_toCopyTo_out)
{
	return m_DoStack.Pop(pITEM_toCopyTo_out);
}


/////////////////////////////////
////////// интерфейс  ///////////
/////////////////////////////////


//"Некое новое действие".
//Эту процедуру нужно вызывать во время очередного изменения среды -
//в качестве параметра передать элемент, который является состоянием среды
//до произведённого действия. Этот элемент поместится в стек UNDO.
//При этом стек DO очищается.
void CDoUndo2::SaveItemBeforeNewAction(const sDoUndo2_item* const pITEM_in)
{
	//сохраняем в стек UNDO и очищаем стек DO
	PushToUndo(pITEM_in);
	m_DoStack.ClearStack();
}

//Действие "UNDO" (откат)
//Эту процедуру нужно вызывать, когда нужен откат.
//В качестве параметра передать элемент, который является текущим состоянием среды
//Этот элемент поместится в стек DO. Элемент же, выбранный из стека UNDO
//будет записан на место *pITEM_in_out - оттуда следует восстаность среду.
//Если процедура вернула false, то стек пуст
bool CDoUndo2::OperationUndo(sDoUndo2_item* const pITEM_in_out)
{
	//если стек Undo пуст - вылазим
	if(m_UndoStack.IsEmpty())return false;
	//сохраняем текущие данные в стек DO
	//и заменяем их данными из стека UNDO
	PushToDo(pITEM_in_out);
	PopFromUndo(pITEM_in_out);
	return true;
}

//Действие "DO" (возврат)
//Эту процедуру нужно вызывать, когда нужен возврат.
//В качестве параметра передать элемент, который является текущим состоянием среды
//Этот элемент поместится в стек UNDO. Элемент же, выбранный из стека DO
//будет записан на место *pITEM_in_out - оттуда следует восстаность среду.
//Если процедура вернула false, то стек пуст
bool CDoUndo2::OperationDo(sDoUndo2_item* const pITEM_in_out)
{
	//если стек Do пуст - вылазим
	if(m_DoStack.IsEmpty())return false;
	//сохраняем текущие данные в стек UNDO
	//и заменяем их данными из стека DO
	PushToUndo(pITEM_in_out);
	PopFromDo(pITEM_in_out);
	return true;
}

//получить количество элементов, помещённых в стек DO
int CDoUndo2::GetDoFilledNum()
{
	return m_DoStack.GetFilledNum();
}

//получить количество элементов, помещённых в стек UNDO
int CDoUndo2::GetUndoFilledNum()
{
	return m_UndoStack.GetFilledNum();
}

