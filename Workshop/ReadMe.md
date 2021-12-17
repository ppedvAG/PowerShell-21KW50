## Notizen

### zum verhindern der "Verzögerungen" von AD
```powershell
$DC = (Resolve-DnsName -Name ppedv.kurs -Type A)[0]
$DCName = (Resolve-DnsName -Name $DC.IP4Address ).NameHost
```
Dadurch wird immer der gleiche DC verwendet.