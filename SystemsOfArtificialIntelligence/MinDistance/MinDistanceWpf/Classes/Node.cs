using System;
using System.Collections.Generic;
using System.Windows;

namespace MinDistanceWpf.Classes
{
    public class Node:IComparable<Node>
    {
        private Point _drawingLocation;
        private Point _center;
        private string _label;
        private double _diameter;
        private bool _visited;
        private double _totalCost;

        private List<Edge> _edges;
        private Edge _edgeCameFrom;

        public Node(Point location, string label, double diameter)
        {
            this._drawingLocation = location;
            this._label = label;
            this._diameter = diameter;

            _visited = false;

            _edges = new List<Edge>();
            _totalCost = -1;
        }

        public Node(Point location, Point center, string label, double diameter)
            :this(location,label,diameter)
        {
            this._center = center;
        }

        public Point Location
        {
            get { return _drawingLocation; }
        }

        public Point Center
        {
            get { return _center; }
            set { this._center = value; }
        }

        public double Diameter
        {
            get { return _diameter; }
        }

        public string Label
        {
            get { return _label; }
        }

        public double TotalCost
        {
            get { return _totalCost; }
            set { this._totalCost = value; }
        }

        public List<Edge> Edges
        {
            get { return this._edges; }
            set { this._edges = value; }
        }

        public Edge EdgeCameFrom
        {
            get { return this._edgeCameFrom; }
            set { this._edgeCameFrom = value; }
        }

        public bool HasPoint(Point p)
        {
            double xSq = Math.Pow(p.X - _center.X,2);
            double ySq = Math.Pow(p.Y - _center.Y,2);
            double dist = Math.Sqrt(xSq + ySq);

            return (dist <= (_diameter/2));
        }

        public bool Visited
        {
            get { return _visited; }
            set { this._visited = value; }
        }

        public int CompareTo(Node n)
        {
            return this._totalCost.CompareTo(n.TotalCost);
        }

        public void Reset()
        {
            _visited = false;
            _edgeCameFrom = null;
            _totalCost = -1;
        }
    }
}
