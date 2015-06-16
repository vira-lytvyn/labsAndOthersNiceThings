using System.Collections.Generic;

namespace MinDistanceWpf.Classes
{
    public class ReachableNodeList
    {
        private List<ReachableNode> _rnList;
        private List<Node> _nodes;
        private Dictionary<Node, ReachableNode> _rnDictionary;

        public ReachableNodeList()
        {
            _rnList = new List<ReachableNode>();
            _nodes = new List<Node>();
            _rnDictionary = new Dictionary<Node, ReachableNode>();
        }

        public void AddReachableNode(ReachableNode rn)
        {
            if (_nodes.Contains(rn.Node))
            {
                ReachableNode oldRN = GetReachableNodeFromNode(rn.Node);
                if (rn.Edge.Length < oldRN.Edge.Length)
                    oldRN.Edge = rn.Edge;
            }
            else
            {
                _rnList.Add(rn);
                _nodes.Add(rn.Node);
                _rnDictionary.Add(rn.Node, rn);
            }
        }

        public List<ReachableNode> ReachableNodes
        {
            get { return this._rnList; }
        }

        public void RemoveReachableNode(ReachableNode rn)
        {
            _rnList.Remove(rn);
            _nodes.Remove(rn.Node);
        }

        public bool HasNode(Node n)
        {
            return _nodes.Contains(n);
        }

        public ReachableNode GetReachableNodeFromNode(Node n)
        {
            if (_rnDictionary.ContainsKey(n))
            {
                return _rnDictionary[n];
            }
            else
            {
                return null;
            }
        }

        public void SortReachableNodes()
        {
            _rnList.Sort();
        }

        public void Clear()
        {
            this._rnList.Clear();
            this._nodes.Clear();
            this._rnDictionary.Clear();
        }
    }
}
