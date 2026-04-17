using System;
using System.Configuration;
using System.Windows.Forms;
using MySqlConnector;

namespace FreshSzalonAdmin
{
    public class DatabaseManager
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["FreshSzalonDb"].ConnectionString;

        public MySqlConnection GetConnection()
        {
            return new MySqlConnection(connectionString);
        }

        public bool TestConnection()
        {
            try
            {
                using (var conn = GetConnection())
                {
                    conn.Open();
                    return true;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba az adatbázis csatlakozásakor:\n" + ex.Message, "Hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        }

        public bool HozzaadUjDolgozo(string nev, string email, string telefon, string jelszo, string bio, string kepNev)
        {
            try
            {
                using (var conn = GetConnection())
                {
                    conn.Open();

                    string query = "INSERT INTO dolgozo (nev, email, telefon, jelszo, bio, kep) " +
                                   "VALUES (@nev, @email, @telefon, @jelszo, @bio, @kep)";

                    using (var cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@nev", nev);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@telefon", telefon);
                        cmd.Parameters.AddWithValue("@jelszo", jelszo);
                        cmd.Parameters.AddWithValue("@bio", bio);
                        cmd.Parameters.AddWithValue("@kep", kepNev);

                        int erintettSorok = cmd.ExecuteNonQuery();
                        return erintettSorok > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a dolgozó mentésekor:\n{ex.Message}", "Adatbázis hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        }

        public System.Data.DataTable GetVendegJogok(int id)
        {
            MySqlConnection conn = GetConnection();
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("SELECT velemenyt_irhat, foglalhat FROM felhasznalo WHERE id = @id", conn);
            cmd.Parameters.AddWithValue("@id", id);

            MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
            System.Data.DataTable dt = new System.Data.DataTable();
            adapter.Fill(dt);

            conn.Close();
            return dt;
        }

        public void FrissitVendegJogok(int id, int velemeny, int foglalas)
        {
            MySqlConnection conn = GetConnection();
            conn.Open();
            MySqlCommand cmd = new MySqlCommand("UPDATE felhasznalo SET velemenyt_irhat = @v, foglalhat = @f WHERE id = @id", conn);
            cmd.Parameters.AddWithValue("@v", velemeny);
            cmd.Parameters.AddWithValue("@f", foglalas);
            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public MySqlDataAdapter GetDolgozokCombo()
        {
            MySqlConnection conn = GetConnection();
            return new MySqlDataAdapter("SELECT id, nev FROM dolgozo", conn);
        }

        public MySqlDataAdapter GetLehetosegekCombo()
        {
            MySqlConnection conn = GetConnection();
            return new MySqlDataAdapter("SELECT id, nev FROM lehetosegek", conn);
        }

        public bool HozzaadSzolgaltato(int dolgozoId, int lehetosegId)
        {
            try
            {
                using (var conn = GetConnection())
                {
                    conn.Open();
                    string query = "INSERT INTO szolgaltatok (dolgozo_id, lehetosegek_id) VALUES (@dId, @lId)";
                    using (var cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@dId", dolgozoId);
                        cmd.Parameters.AddWithValue("@lId", lehetosegId);

                        int erintettSorok = cmd.ExecuteNonQuery();
                        return erintettSorok > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Hiba a hozzárendelés mentésekor:\n{ex.Message}", "Adatbázis hiba", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        }
    }
}
