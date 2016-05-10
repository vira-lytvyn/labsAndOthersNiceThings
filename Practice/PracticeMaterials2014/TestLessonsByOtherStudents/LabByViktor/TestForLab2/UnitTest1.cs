using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using lab_2;

namespace TestForLab2
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void CheckBinaryToDecimal1()
        {
            Assert.AreEqual(Coder.BinaryToInteger("001"), 1);
        }

        [TestMethod]
        public void CheckBinaryToDecimal2()
        {
            Assert.AreEqual(Coder.BinaryToInteger("11000111010110100001010010"), 52258898);
        }

        [TestMethod]
        public void CheckBinaryToDecimal3()
        {
            Assert.AreEqual(Coder.BinaryToInteger("000"), -2);
        }
        [TestMethod]
        public void CheckIntegerToBinary1()
        {
            Assert.AreEqual(Coder.IntegerToBinary(5), "101");
        }
        [TestMethod]
        public void CheckIntegerToBinary2()
        {
            Assert.AreEqual(Coder.IntegerToBinary(523741287), "11111001101111010100001100111");
        }
        [TestMethod]
        public void CheckIntegerToBinary3()
        {
            Assert.AreEqual(Coder.IntegerToBinary(-3), "111");
        }
        [TestMethod]
        public void CheckIDFromHex1()
        {
            Assert.AreEqual(Coder.IDFromHex("A1"), 161);
        }
        [TestMethod]
        public void CheckIDFromHex2()
        {
            Assert.AreEqual(Coder.IDFromHex("1F37A867"), 523741287);
        }
        [TestMethod]
        public void CheckIDFromHex3()
        {
            Assert.AreEqual(Coder.IDFromHex("MLC5"), 555);
        }
        [TestMethod]
        public void CheckHexFromID1()
        {
            Assert.AreEqual(Coder.HexFromID(10), "A");
        }
        [TestMethod]
        public void CheckHexFromID2()
        {
            Assert.AreEqual(Coder.HexFromID(7325698), "6FC802");
        }
        [TestMethod]
        public void CheckHexFromID3()
        {
            Assert.AreEqual(Coder.HexFromID(16), "K");
        }
    }
}
