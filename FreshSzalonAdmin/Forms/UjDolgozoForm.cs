using System;
using System.Windows.Forms;
using MaterialSkin;
using MaterialSkin.Controls;
using MySqlConnector;

namespace FreshSzalonAdmin
{
    public partial class UjDolgozoForm : MaterialForm
    {
        DatabaseManager adatbazis = new DatabaseManager();
        public UjDolgozoForm()
        {
            InitializeComponent();
            this.Text = "Új dolgozó felvétele";

            var skinManager = MaterialSkinManager.Instance;
            skinManager.AddFormToManage(this);
        }

        private void btnMegse_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private string kivalasztottKepNev = "default.jpg";
        private void btnKepValasztas_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Filter = "Image Files (*.jpg)|*.jpg";
                ofd.Title = "Válassz ki egy dolgozói fotót!";

                if (ofd.ShowDialog() == DialogResult.OK)
                {
                    kivalasztottKepNev = System.IO.Path.GetFileName(ofd.FileName);
                    lblKepEleres.Text = kivalasztottKepNev;

                }
            }
        }

        private void btnMentes_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNev.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtJelszo.Text))
            {
                MessageBox.Show("A Név, E-mail és Jelszó megadása kötelező!", "Figyelmeztetés", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            string titkositottJelszo = BCrypt.Net.BCrypt.HashPassword(txtJelszo.Text, 12);
            titkositottJelszo = titkositottJelszo.Replace("$2a$", "$2y$").Replace("$2b$", "$2y$");

            bool sikeresMentes = adatbazis.HozzaadUjDolgozo(txtNev.Text, txtEmail.Text, txtTelefon.Text, titkositottJelszo, txtBio.Text, kivalasztottKepNev);

            if (sikeresMentes)
            {
                MessageBox.Show("Sikeresen felvetted az új dolgozót!", "Siker", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();
            }
        }
    }
}
