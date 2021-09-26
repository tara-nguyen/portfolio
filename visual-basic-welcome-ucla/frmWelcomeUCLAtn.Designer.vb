<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmWelcome
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblTitle = New System.Windows.Forms.Label()
        Me.lblName = New System.Windows.Forms.Label()
        Me.txtName = New System.Windows.Forms.TextBox()
        Me.lblAge = New System.Windows.Forms.Label()
        Me.txtAge = New System.Windows.Forms.TextBox()
        Me.lblMajor = New System.Windows.Forms.Label()
        Me.lblEnrollRoom = New System.Windows.Forms.Label()
        Me.chkStudent = New System.Windows.Forms.CheckBox()
        Me.chkResident = New System.Windows.Forms.CheckBox()
        Me.grpResidence = New System.Windows.Forms.GroupBox()
        Me.rdoSaxon = New System.Windows.Forms.RadioButton()
        Me.rdoDeNeve = New System.Windows.Forms.RadioButton()
        Me.rdoSproul = New System.Windows.Forms.RadioButton()
        Me.cboMajor = New System.Windows.Forms.ComboBox()
        Me.btnIncreaseAge = New System.Windows.Forms.Button()
        Me.btnExit = New System.Windows.Forms.Button()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.FileToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PrintFormToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ScenarioToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.HelpToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem1 = New System.Windows.Forms.ToolStripSeparator()
        Me.ExitToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.GradStudentToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FacultyRAToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.AboutWelcomeUCLAToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.grpResidence.SuspendLayout()
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblTitle
        '
        Me.lblTitle.AutoSize = True
        Me.lblTitle.Font = New System.Drawing.Font("Microsoft Sans Serif", 24.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTitle.Location = New System.Drawing.Point(244, 9)
        Me.lblTitle.Name = "lblTitle"
        Me.lblTitle.Size = New System.Drawing.Size(296, 37)
        Me.lblTitle.TabIndex = 0
        Me.lblTitle.Text = "Welcome to UCLA"
        '
        'lblName
        '
        Me.lblName.AutoSize = True
        Me.lblName.Location = New System.Drawing.Point(83, 91)
        Me.lblName.Name = "lblName"
        Me.lblName.Size = New System.Drawing.Size(35, 13)
        Me.lblName.TabIndex = 1
        Me.lblName.Text = "&Name"
        '
        'txtName
        '
        Me.txtName.Location = New System.Drawing.Point(140, 88)
        Me.txtName.Name = "txtName"
        Me.txtName.Size = New System.Drawing.Size(160, 20)
        Me.txtName.TabIndex = 2
        '
        'lblAge
        '
        Me.lblAge.AutoSize = True
        Me.lblAge.Location = New System.Drawing.Point(83, 129)
        Me.lblAge.Name = "lblAge"
        Me.lblAge.Size = New System.Drawing.Size(26, 13)
        Me.lblAge.TabIndex = 3
        Me.lblAge.Text = "&Age"
        '
        'txtAge
        '
        Me.txtAge.Location = New System.Drawing.Point(140, 126)
        Me.txtAge.Name = "txtAge"
        Me.txtAge.Size = New System.Drawing.Size(48, 20)
        Me.txtAge.TabIndex = 4
        '
        'lblMajor
        '
        Me.lblMajor.AutoSize = True
        Me.lblMajor.Location = New System.Drawing.Point(456, 182)
        Me.lblMajor.Name = "lblMajor"
        Me.lblMajor.Size = New System.Drawing.Size(33, 13)
        Me.lblMajor.TabIndex = 8
        Me.lblMajor.Text = "&Major"
        '
        'lblEnrollRoom
        '
        Me.lblEnrollRoom.BackColor = System.Drawing.Color.SeaShell
        Me.lblEnrollRoom.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.lblEnrollRoom.Font = New System.Drawing.Font("Microsoft Sans Serif", 15.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblEnrollRoom.Location = New System.Drawing.Point(206, 380)
        Me.lblEnrollRoom.Name = "lblEnrollRoom"
        Me.lblEnrollRoom.Size = New System.Drawing.Size(373, 58)
        Me.lblEnrollRoom.TabIndex = 12
        Me.lblEnrollRoom.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'chkStudent
        '
        Me.chkStudent.AutoSize = True
        Me.chkStudent.Checked = True
        Me.chkStudent.CheckState = System.Windows.Forms.CheckState.Checked
        Me.chkStudent.Location = New System.Drawing.Point(459, 90)
        Me.chkStudent.Name = "chkStudent"
        Me.chkStudent.Size = New System.Drawing.Size(63, 17)
        Me.chkStudent.TabIndex = 6
        Me.chkStudent.Text = "&Student"
        Me.chkStudent.UseVisualStyleBackColor = True
        '
        'chkResident
        '
        Me.chkResident.AutoSize = True
        Me.chkResident.Location = New System.Drawing.Point(459, 128)
        Me.chkResident.Name = "chkResident"
        Me.chkResident.Size = New System.Drawing.Size(68, 17)
        Me.chkResident.TabIndex = 7
        Me.chkResident.Text = "&Resident"
        Me.chkResident.UseVisualStyleBackColor = True
        '
        'grpResidence
        '
        Me.grpResidence.Controls.Add(Me.rdoSaxon)
        Me.grpResidence.Controls.Add(Me.rdoDeNeve)
        Me.grpResidence.Controls.Add(Me.rdoSproul)
        Me.grpResidence.Location = New System.Drawing.Point(86, 182)
        Me.grpResidence.Name = "grpResidence"
        Me.grpResidence.Size = New System.Drawing.Size(255, 136)
        Me.grpResidence.TabIndex = 5
        Me.grpResidence.TabStop = False
        Me.grpResidence.Text = "Residence Hall"
        '
        'rdoSaxon
        '
        Me.rdoSaxon.AutoSize = True
        Me.rdoSaxon.Location = New System.Drawing.Point(29, 95)
        Me.rdoSaxon.Name = "rdoSaxon"
        Me.rdoSaxon.Size = New System.Drawing.Size(87, 17)
        Me.rdoSaxon.TabIndex = 2
        Me.rdoSaxon.Text = "Saxon S&uites"
        Me.rdoSaxon.UseVisualStyleBackColor = True
        '
        'rdoDeNeve
        '
        Me.rdoDeNeve.AutoSize = True
        Me.rdoDeNeve.Location = New System.Drawing.Point(29, 63)
        Me.rdoDeNeve.Name = "rdoDeNeve"
        Me.rdoDeNeve.Size = New System.Drawing.Size(94, 17)
        Me.rdoDeNeve.TabIndex = 1
        Me.rdoDeNeve.Text = "&DeNeve Plaza"
        Me.rdoDeNeve.UseVisualStyleBackColor = True
        '
        'rdoSproul
        '
        Me.rdoSproul.AutoSize = True
        Me.rdoSproul.Checked = True
        Me.rdoSproul.Location = New System.Drawing.Point(29, 31)
        Me.rdoSproul.Name = "rdoSproul"
        Me.rdoSproul.Size = New System.Drawing.Size(76, 17)
        Me.rdoSproul.TabIndex = 0
        Me.rdoSproul.TabStop = True
        Me.rdoSproul.Text = "S&proul Hall"
        Me.rdoSproul.UseVisualStyleBackColor = True
        '
        'cboMajor
        '
        Me.cboMajor.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboMajor.FormattingEnabled = True
        Me.cboMajor.Items.AddRange(New Object() {"English", "Cybernetics", "Kinesiology", "Mathematics", "Music"})
        Me.cboMajor.Location = New System.Drawing.Point(459, 209)
        Me.cboMajor.Name = "cboMajor"
        Me.cboMajor.Size = New System.Drawing.Size(169, 21)
        Me.cboMajor.TabIndex = 9
        '
        'btnIncreaseAge
        '
        Me.btnIncreaseAge.Location = New System.Drawing.Point(459, 281)
        Me.btnIncreaseAge.Name = "btnIncreaseAge"
        Me.btnIncreaseAge.Size = New System.Drawing.Size(99, 37)
        Me.btnIncreaseAge.TabIndex = 10
        Me.btnIncreaseAge.Text = "&Increase Age"
        Me.btnIncreaseAge.UseVisualStyleBackColor = True
        '
        'btnExit
        '
        Me.btnExit.Location = New System.Drawing.Point(584, 281)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(99, 37)
        Me.btnExit.TabIndex = 11
        Me.btnExit.Text = "E&xit"
        Me.btnExit.UseVisualStyleBackColor = True
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FileToolStripMenuItem, Me.ScenarioToolStripMenuItem, Me.HelpToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(784, 24)
        Me.MenuStrip1.TabIndex = 13
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'FileToolStripMenuItem
        '
        Me.FileToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.PrintFormToolStripMenuItem, Me.ToolStripMenuItem1, Me.ExitToolStripMenuItem})
        Me.FileToolStripMenuItem.Name = "FileToolStripMenuItem"
        Me.FileToolStripMenuItem.Size = New System.Drawing.Size(37, 20)
        Me.FileToolStripMenuItem.Text = "&File"
        '
        'PrintFormToolStripMenuItem
        '
        Me.PrintFormToolStripMenuItem.Name = "PrintFormToolStripMenuItem"
        Me.PrintFormToolStripMenuItem.Size = New System.Drawing.Size(180, 22)
        Me.PrintFormToolStripMenuItem.Text = "&Print Form"
        '
        'ScenarioToolStripMenuItem
        '
        Me.ScenarioToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.GradStudentToolStripMenuItem, Me.FacultyRAToolStripMenuItem})
        Me.ScenarioToolStripMenuItem.Name = "ScenarioToolStripMenuItem"
        Me.ScenarioToolStripMenuItem.Size = New System.Drawing.Size(64, 20)
        Me.ScenarioToolStripMenuItem.Text = "S&cenario"
        '
        'HelpToolStripMenuItem
        '
        Me.HelpToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.AboutWelcomeUCLAToolStripMenuItem})
        Me.HelpToolStripMenuItem.Name = "HelpToolStripMenuItem"
        Me.HelpToolStripMenuItem.Size = New System.Drawing.Size(44, 20)
        Me.HelpToolStripMenuItem.Text = "&Help"
        '
        'ToolStripMenuItem1
        '
        Me.ToolStripMenuItem1.Name = "ToolStripMenuItem1"
        Me.ToolStripMenuItem1.Size = New System.Drawing.Size(177, 6)
        '
        'ExitToolStripMenuItem
        '
        Me.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem"
        Me.ExitToolStripMenuItem.Size = New System.Drawing.Size(180, 22)
        Me.ExitToolStripMenuItem.Text = "E&xit"
        '
        'GradStudentToolStripMenuItem
        '
        Me.GradStudentToolStripMenuItem.Name = "GradStudentToolStripMenuItem"
        Me.GradStudentToolStripMenuItem.Size = New System.Drawing.Size(180, 22)
        Me.GradStudentToolStripMenuItem.Text = "&Grad Student"
        '
        'FacultyRAToolStripMenuItem
        '
        Me.FacultyRAToolStripMenuItem.Name = "FacultyRAToolStripMenuItem"
        Me.FacultyRAToolStripMenuItem.Size = New System.Drawing.Size(180, 22)
        Me.FacultyRAToolStripMenuItem.Text = "&Faculty RA"
        '
        'AboutWelcomeUCLAToolStripMenuItem
        '
        Me.AboutWelcomeUCLAToolStripMenuItem.Name = "AboutWelcomeUCLAToolStripMenuItem"
        Me.AboutWelcomeUCLAToolStripMenuItem.Size = New System.Drawing.Size(190, 22)
        Me.AboutWelcomeUCLAToolStripMenuItem.Text = "&About WelcomeUCLA"
        '
        'frmWelcome
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(784, 561)
        Me.Controls.Add(Me.btnExit)
        Me.Controls.Add(Me.btnIncreaseAge)
        Me.Controls.Add(Me.cboMajor)
        Me.Controls.Add(Me.grpResidence)
        Me.Controls.Add(Me.chkResident)
        Me.Controls.Add(Me.chkStudent)
        Me.Controls.Add(Me.lblEnrollRoom)
        Me.Controls.Add(Me.lblMajor)
        Me.Controls.Add(Me.txtAge)
        Me.Controls.Add(Me.lblAge)
        Me.Controls.Add(Me.txtName)
        Me.Controls.Add(Me.lblName)
        Me.Controls.Add(Me.lblTitle)
        Me.Controls.Add(Me.MenuStrip1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "frmWelcome"
        Me.Text = "WelcomeUCLA App"
        Me.grpResidence.ResumeLayout(False)
        Me.grpResidence.PerformLayout()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents lblTitle As Label
    Friend WithEvents lblName As Label
    Friend WithEvents txtName As TextBox
    Friend WithEvents lblAge As Label
    Friend WithEvents txtAge As TextBox
    Friend WithEvents lblMajor As Label
    Friend WithEvents lblEnrollRoom As Label
    Friend WithEvents chkStudent As CheckBox
    Friend WithEvents chkResident As CheckBox
    Friend WithEvents grpResidence As GroupBox
    Friend WithEvents rdoSaxon As RadioButton
    Friend WithEvents rdoDeNeve As RadioButton
    Friend WithEvents rdoSproul As RadioButton
    Friend WithEvents cboMajor As ComboBox
    Friend WithEvents btnIncreaseAge As Button
    Friend WithEvents btnExit As Button
    Friend WithEvents MenuStrip1 As MenuStrip
    Friend WithEvents FileToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ScenarioToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents HelpToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents PrintFormToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItem1 As ToolStripSeparator
    Friend WithEvents ExitToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents GradStudentToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents FacultyRAToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents AboutWelcomeUCLAToolStripMenuItem As ToolStripMenuItem
End Class
