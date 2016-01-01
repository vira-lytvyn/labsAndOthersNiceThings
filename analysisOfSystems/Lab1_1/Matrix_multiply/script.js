/**
 * Created with JetBrains WebStorm.
 * User: CHICHEK
 * Date: 24.03.13
 * Time: 0:09
 * To change this template use File | Settings | File Templates.
 */
var counter = 0;
function matrixMult()
{
    counter++; // лічильник кількості обрахунків
    var rowsInput = document.getElementById("rows").value;
    var colsInput = document.getElementById("columns").value;
    var output    = document.getElementById("output");
    output.value  += "Результат " + counter + "-го прикладу\n\n";
    rows = rowsInput.split(','); // розділяє введені через кому розмірності
    cols = colsInput.split(',');
    n = rows.length;
    /* Перевірка на можливість множення */
    var isM = true;
    for( i = 0; i < n-1; i ++ )
    {
        if ( cols[i] != rows[i+1] )
        {
            alert("Множення неможливе! Розмірності не співпадають");
            isM = false;
            break;
        }
    }
    /* оголошуємо масиви */
    matrix = _2DArray(n,n);
    sequence = _2DArray(n,n);

    /* починаємо обчислення */
    for( d = 1; d <= n ; d++)
    {
        for ( i = 0; i < n - d; i++)
        {
            j = i + d;
            matrix[i][j] = 2147483647;
            for( k = i; k <= j - 1;k++)
            {	m = matrix[i][k] + matrix[k+1][j] + rows[i]*cols[k]*cols[j];
                if ( m < matrix[i][j] )
                {
                    matrix[i][j] = m;
                    sequence[i][j] = k;
                }
            }
        }
    }
    output.value += "Кількість операцій: " + matrix[0][n-1] + "\n";
    output.value += "Оптимальний порядок: " + parenthesize(sequence, 0, n-1) + "\n";
}
//Функція для формування стрічки із записом найкращого розв'язку
function parenthesize(array, i, j)
{
    if ( j > i )
        s = "(" + parenthesize(array, i, array[i][j]) + "*" + parenthesize(array,array[i][j]+1,j) + ")";
    else
        s = characterMap(i);
    return s;
}
//Масив індексів
function characterMap(i)
{
    letters = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
    return "A" + i;
//    return letters[i];
}
//Функція для обнулення матриць
function _2DArray(rows,cols)
{
    var i;
    var j;
    var a = new Array(rows);
    for (i=0; i < rows; i++)
    {
        a[i] = new Array(cols);
        for (j=0; j < cols; j++)
        {
            a[i][j] = 0;
        }
    }
    return(a);
}
function clearOutput()
{
    document.getElementById("output").value = "";
}