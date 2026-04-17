using Microsoft.VisualStudio.TestTools.UnitTesting;
using FreshSzalonAdmin;
using System.Data;
using MySqlConnector;

namespace FreshSzalonAdmin.Tests
{
    [TestClass]
    public class DatabaseManagerTests
    {
        [TestMethod]
        public void TestConnection_SikeresKapcsolatEseten_TrueErteketAdVissza()
        {
            DatabaseManager adatbazis = new DatabaseManager();
            bool eredmeny = adatbazis.TestConnection();
            Assert.IsTrue(eredmeny, "Az adatbázis kapcsolat sikertelen! Be van kapcsolva a XAMPP?");
        }

        [TestMethod]
        public void GetConnection_SikeresHivas_VisszaadjaAKapcsolatot()
        {
            DatabaseManager adatbazis = new DatabaseManager();


            var kapcsolat = adatbazis.GetConnection();

            Assert.IsNotNull(kapcsolat, "A GetConnection() null értéket adott vissza!");
        }

        [TestMethod]
        public void GetConnection_KapcsolatMegnyitasa_SikeresNyitas()
        {
            DatabaseManager adatbazis = new DatabaseManager();
            var kapcsolat = adatbazis.GetConnection();

            try
            {
                kapcsolat.Open(); 


                Assert.AreEqual(System.Data.ConnectionState.Open, kapcsolat.State, "A kapcsolatot nem sikerült megnyitni!");
            }
            finally
            {

                if (kapcsolat.State == System.Data.ConnectionState.Open)
                {
                    kapcsolat.Close();
                }
            }
        }
    }
}