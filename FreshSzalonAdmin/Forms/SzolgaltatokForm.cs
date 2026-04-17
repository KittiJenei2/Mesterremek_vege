using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MaterialSkin;
using MaterialSkin.Controls;

namespace FreshSzalonAdmin.Forms
{
    public partial class SzolgaltatokForm : MaterialForm
    {
        DatabaseManager adatbazis = new DatabaseManager();
        public SzolgaltatokForm()
        {
            InitializeComponent();

            this.Text = "Összekapcsolás";

            var skinManager = MaterialSkinManager.Instance;
            skinManager.AddFormToManage(this);
        }

        private void SzolgaltatokForm_Load(object sender, EventArgs e)
        {
            DataTable dtDolgozok = new DataTable();
            adatbazis.GetDolgozokCombo().Fill(dtDolgozok);
            cmbDolgozo.DataSource = dtDolgozok;
            cmbDolgozo.DisplayMember = "nev";
            cmbDolgozo.ValueMember = "id";

            DataTable dtLehetosegek = new DataTable();
            adatbazis.GetLehetosegekCombo().Fill(dtLehetosegek);
            cmbLehetoseg.DataSource = dtLehetosegek;
            cmbLehetoseg.DisplayMember = "nev";
            cmbLehetoseg.ValueMember = "id";

            cmbDolgozo.SelectedIndex = -1;
            cmbLehetoseg.SelectedIndex = -1;
        }

        private void btnMentes_Click(object sender, EventArgs e)
        {
            if (cmbDolgozo.SelectedValue == null || cmbLehetoseg.SelectedValue == null)
            {
                MessageBox.Show("Kérlek válassz ki egy dolgozót és egy lehetőséget is!", "Figyelmeztetés", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            int dolgozoId = Convert.ToInt32(cmbDolgozo.SelectedValue);
            int lehetosegId = Convert.ToInt32(cmbLehetoseg.SelectedValue);

            if (adatbazis.HozzaadSzolgaltato(dolgozoId, lehetosegId))
            {
                MessageBox.Show("Sikeres hozzárendelés!", "Siker", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();
            }
        }

        private void btnMegse_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
