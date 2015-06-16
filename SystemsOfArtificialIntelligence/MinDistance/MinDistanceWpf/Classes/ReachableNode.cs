using System;

namespace MinDistanceWpf.Classes
{
    public class ReachableNode : IComparable<ReachableNode>
    {
        private Node _n;
        private Edge _e;
        public ReachableNode(Node n, Edge e)
        {
            this._n = n;
            this._e = e;
        }

        public double TotalCost
        {
            get { return _n.TotalCost; }
        }

        public Node Node
        {
            get { return this._n; }
            set { this._n = value; }
        }

        public Edge Edge
        {
            get { return this._e; }
            set { this._e = value; }
        }

        public int CompareTo(ReachableNode rn)
        {
            return this.Node.TotalCost.CompareTo(rn.Node.TotalCost);
        }
    }
}
