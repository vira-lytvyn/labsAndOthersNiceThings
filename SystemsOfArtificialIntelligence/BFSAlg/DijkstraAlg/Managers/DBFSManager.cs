using System;
using System.Collections.Generic;
using System.Drawing;
using System.Runtime.InteropServices;
using DijkstraAlg.Administrating;
using DijkstraAlg.Helpers;

namespace DijkstraAlg.Managers
{
    public class DBFSManager
    {
        public static void Manage(MainApp app, Graphics graphics)
        {
            var listOfResults = new List<long>();
            var ourLocalTree = new BinarySearchTree();
            Constants.result = Convert.ToInt32(app.Result.Text);
            foreach (var variable in GenerateTree.OurTree)
            {
                ourLocalTree.Insert(variable.Key);
            }
            if (app.AlgType.Text == Constants.DFS)
            {
                listOfResults = DFSAlg(ourLocalTree);
            }
            else if (app.AlgType.Text == Constants.BFS)
            {
                listOfResults = BFSAlg(ourLocalTree);
            }
            DrawWay.Draw(graphics, GenerateTree.OurTree, listOfResults);
        }

        public static List<long> DFSAlg(BinarySearchTree tree)
        {
            var result = new List<long>();
            var stack = new Stack<BinarySearchTree.TreeNode>();
            stack.Push(tree.root);
            while (stack.Count > 0)
            {
                var n = stack.Pop();
                result.Add(n.data);
                if (n.right != null)
                    stack.Push(n.right);
                if (n.left != null)
                    stack.Push(n.left);
            }
            return result;
        }

        private static List<long> BFSAlg(BinarySearchTree tree)
        {
            var result = new List<long>();
            var queue = new Queue<BinarySearchTree.TreeNode>();
            queue.Enqueue(tree.root);
            while (queue.Count > 0)
            {
                var n = queue.Dequeue();
                result.Add(n.data);
                if (n.left != null)
                    queue.Enqueue(n.left);
                if (n.right != null)
                    queue.Enqueue(n.right);
            }
            return result;
        }
    }
}
