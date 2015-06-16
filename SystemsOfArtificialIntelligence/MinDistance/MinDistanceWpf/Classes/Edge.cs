using System;

namespace MinDistanceWpf.Classes
{
    public class Edge:IComparable<Edge>
    {
        private double _length;
        private Node _firstNode;
        private Node _secondNode;

        private const int fontSize = 10;
        private bool visited;

        public Edge(Node firstNode, Node secondNode)
        {
            this._firstNode = firstNode;
            this._secondNode = secondNode;

            visited = false;
        }

        public Edge(Node firstNode, Node secondNode, double length)
            : this(firstNode, secondNode)
        {
            this._length = length;
        }

        public Node FirstNode
        {
            get { return this._firstNode; }
            set { this._firstNode = value; }
        }

        public Node SecondNode
        {
            get { return this._secondNode; }
            set { this._secondNode = value; }
        }

        public double Length
        {
            get { return this._length; }
            set { this._length = value; }
        }


        public void Reset()
        {
            visited = false;
        }

        public int CompareTo(Edge otherEdge)
        {
            return this.Length.CompareTo(otherEdge.Length);
        }

        public bool Visited
        {
            get { return visited; }
            set { this.visited = value; }
        }
    }
}
