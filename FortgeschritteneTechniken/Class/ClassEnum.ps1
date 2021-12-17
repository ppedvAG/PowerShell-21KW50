class Auto
{
    [string]$Marke
    [string]$Modell
    [int]$Leistung
    [Antriebsart]$Antrieb
    hidden [string]$GeheimeEigenschaft = "Wert"

    #Konstruktoren müssen erstellt werden für jede Variante !

    Auto()
    {
    }
    Auto([string]$Marke,[string]$Modell,[int]$Leistung)
    {
        $this.Marke = $Marke
        $this.Modell = $Modell
        $this.Leistung = $Leistung
    }


    #eigene Methode
    [void]Drive([int]$Strecke)
    {
        for($i = 1; $i -le $Strecke; $i++)
        {
            Write-Progress -Activity "Fahre" -Status "Bereits $i gefahren" -PercentComplete ((100/$Strecke)*$i)
            Start-Sleep -Milliseconds 50
        }
    }
    # ToString() zu überschreiben durch eine eigene Logik
    [string]ToString()
    {
        [string]$Ausgabe = $this.Marke + " | " + $this.Modell
        return $Ausgabe
    }
}

enum Antriebsart
{
    Undefined
    Elektrisch
    Hybrid
    Benzin
    Diesel
    Wasserstoff = 8
}


$BMW = [Auto]::new("BMW","F31",252)

$Merces = [Auto]::new()
$Merces.Marke = "Mercedes"
$Merces.Modell = "A-Klasse"
$Merces.Leistung = 110