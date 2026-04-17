using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace FreshSzalonAdmin1.Tests
{
    [TestClass]
    public class BiztonsagiTesztek
    {
        [TestMethod]
        public void JelszoTitkositasa_KimenetNemEgyenloEredetiJelszoval()
        {
            string eredetiJelszo = "TitkosJelszo123!";

            string titkositottJelszo = BCrypt.Net.BCrypt.HashPassword(eredetiJelszo);

            Assert.AreNotEqual(eredetiJelszo, titkositottJelszo, "A titkosítás nem működik, a jelszó nyílt szöveg maradt!");

            Assert.IsTrue(titkositottJelszo.Length > 50, "A titkosított jelszó gyanúsan rövid!");
        }

        [TestMethod]
        public void JelszoEllenorzese_HelyesJelszoval_TrueErteketAd()
        {
            string jelszo = "Admin123";
            string hash = BCrypt.Net.BCrypt.HashPassword(jelszo);

            bool helyesE = BCrypt.Net.BCrypt.Verify(jelszo, hash);

            Assert.IsTrue(helyesE, "A rendszer nem ismerte fel a helyesen megadott jelszót!");
        }

        [TestMethod]
        public void JelszoEllenorzese_HelytelenJelszoval_FalseErteketAd()
        {
            string eredetiJelszo = "Admin123";
            string rosszJelszo = "Admin124";
            string hash = BCrypt.Net.BCrypt.HashPassword(eredetiJelszo);

            bool helyesE = BCrypt.Net.BCrypt.Verify(rosszJelszo, hash);

            Assert.IsFalse(helyesE, "Biztonsági rés: A rendszer átengedett egy hibás jelszót!");
        }
    }
}
