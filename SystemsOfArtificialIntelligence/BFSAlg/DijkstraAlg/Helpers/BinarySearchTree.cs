using System;

namespace DijkstraAlg.Managers
{
    public class BinarySearchTree
    {
        public class TreeNode
        {
            public long data;
            public TreeNode left;
            public TreeNode right;

            public TreeNode(long valu)
            {
                this.data = valu;
                left = null;
                right = null;
            }

            public override string ToString()
            {
                return this.data.ToString();
            }

        }

        public TreeNode root;
        public int count;

        public BinarySearchTree()
        {
            this.root = null;
            this.count = 0;
        }

        public int Count
        {
            get { return this.count; }
        }

        public void Insert(long valu)
        {
            if (IsThere(valu) == false)
                Insert(ref this.root, valu);
        }

        public void Insert(ref TreeNode rootNode, long valu)
        {
            if (rootNode == null)
            {
                TreeNode newNode = new TreeNode(valu);
                rootNode = newNode;
                ++this.count;
            }
            else if (valu < rootNode.data)
                Insert(ref rootNode.left, valu);
            else
                Insert(ref rootNode.right, valu);
        }

        public bool IsThere(long valu) 
        {
            return IsThere(this.root, valu);
        }

        public bool IsThere(TreeNode rootNode, long valu)
        {
            if (rootNode == null)
                return false;
            else if (rootNode.data == valu)
                return true;
            else if (valu < rootNode.data)
                return IsThere(rootNode.left, valu);
            else
                return IsThere(rootNode.right, valu);
        }

        public void Display()
        {
            Display(this.root);
        }

        public void Display(TreeNode rootNode)
        {
            if (rootNode != null)
            {
                Display(rootNode.left);
                Console.Write(rootNode.ToString() + "");
                Display(rootNode.right);
            }
        }
    }
}
