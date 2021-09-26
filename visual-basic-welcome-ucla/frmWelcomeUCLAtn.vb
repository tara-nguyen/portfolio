Public Class frmWelcome
    'WelcomeUCLA Program

    Dim intAge As Integer         'age (after validation)
    Dim strEnrollRoom As String   'enrollment room/area
    Const MAXAGE = 130            'maximum age allowed

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub frmWelcome_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        cboMajor.Text = “Mathematics”
        chkStudent.Checked = True   ' Assume user is a student upon form entry
        grpResidence.Enabled = False   'Disable all residence halls upon form entry
    End Sub

    Private Sub btnIncreaseAge_Click(sender As Object, e As EventArgs) Handles btnIncreaseAge.Click
        If Not IsNumeric(txtAge.Text) Then
            MessageBox.Show("Age must be numeric", "User Input Error", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtAge.Clear()
            txtAge.Focus()
        ElseIf txtAge.Text <= 0 Then
            MessageBox.Show("Age must be a positive number", "User Input Error", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtAge.Clear()
            txtAge.Focus()
        ElseIf txtAge.Text > MAXAGE Then
            MessageBox.Show("Age must be " & MAXAGE & " or less", "User Input Error", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtAge.Clear()
            txtAge.Focus()
        Else
            intAge = txtAge.Text
            intAge = intAge + 1
            txtAge.Text = intAge
        End If
    End Sub

    Private Sub chkStudent_CheckedChanged(sender As Object, e As EventArgs) Handles chkStudent.CheckedChanged
        If chkStudent.Checked = True Then
            lblMajor.Enabled = True
            cboMajor.Enabled = True
            lblEnrollRoom.Visible = True
        Else
            lblMajor.Enabled = False
            cboMajor.Enabled = False
            lblEnrollRoom.Visible = False
        End If
    End Sub

    Private Sub chkResident_CheckedChanged(sender As Object, e As EventArgs) Handles chkResident.CheckedChanged
        If chkResident.Checked Then
            grpResidence.Enabled = True
        Else
            grpResidence.Enabled = False
        End If
    End Sub

    Private Sub cboMajor_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cboMajor.SelectedIndexChanged
        'Determine enrollment room/area based on major

        If cboMajor.Text = "English" Or cboMajor.Text = "Kinesiology" Then
            strEnrollRoom = "Rolfe Hall Lobby"
        ElseIf cboMajor.Text = "Mathematics" Or cboMajor.Text = "Cybernetics" Then
            strEnrollRoom = "Boelter 6267"
        Else
            strEnrollRoom = "Murphy Hall Registrar"
        End If

        lblEnrollRoom.Text = "Enroll Room: " & strEnrollRoom
    End Sub

    Private Sub PrintFormToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles PrintFormToolStripMenuItem.Click
        PrintFormToolStripMenuItem.Enabled = False
    End Sub

    Private Sub ExitToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ExitToolStripMenuItem.Click
        Me.Close()
    End Sub

    Private Sub GradStudentToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles GradStudentToolStripMenuItem.Click
        chkStudent.Checked = True
        rdoSaxon.Checked = True
    End Sub

    Private Sub FacultyRAToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FacultyRAToolStripMenuItem.Click
        chkStudent.Checked = False
        chkResident.Checked = True
    End Sub

    Private Sub AboutWelcomeUCLAToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles AboutWelcomeUCLAToolStripMenuItem.Click
        MessageBox.Show("WelcomeUCLA Program, Copyright 2020 by Tara Nguyen", "About WelcomeUCLA", MessageBoxButtons.OK, MessageBoxIcon.Information)
    End Sub
End Class
