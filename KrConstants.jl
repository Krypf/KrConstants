#%% /usr/local/var/pyenv/versions/3.8.6/lib/python3.8/site-packages/scipy/constants/constants.py
# SI prefixes
yotta = 1e24
zetta = 1e21
exa = 1e18
peta = 1e15
tera = 1e12
giga = 1e9
mega = 1e6
kilo = 1e3
hecto = 1e2
deka = 1e1
deci = 1e-1
centi = 1e-2
milli = 1e-3
micro = 1e-6
nano = 1e-9
pico = 1e-12
femto = 1e-15
atto = 1e-18
zepto = 1e-21
#%% /usr/local/var/pyenv/versions/3.8.6/lib/python3.8/site-packages/scipy/constants/codata.py
_codata2018 = 
"
speed of light in vacuum                                    ;299 792 458              ;(exact)                  ;m s^-1
Avogadro constant                                           ;6.022 140 76 e23         ;(exact)                  ;mol^-1
Boltzmann constant                                          ;1.380 649 e-23           ;(exact)                  ;J K^-1
fine-structure constant                                     ;7.297 352 5693 e-3       ;0.000 000 0011 e-3;
molar gas constant                                          ;8.314 462 618...         ;(exact)                  ;J mol^-1 K^-1
Newtonian constant of gravitation                           ;6.674 30 e-11            ;0.000 15 e-11            ;m^3 kg^-1 s^-2
Planck constant                                             ;6.626 070 15 e-34        ;(exact)                  ;J Hz^-1
reduced Planck constant                                     ;1.054 571 817... e-34    ;(exact)                  ;J s
Rydberg constant                                            ;10 973 731.568 160       ;0.000 021                ;m^-1
electron mass                                               ;9.109 383 7015 e-31      ;0.000 000 0028 e-31      ;kg
muon mass                                                   ;1.883 531 627 e-28       ;0.000 000 042 e-28       ;kg
neutron mass                                                ;1.674 927 498 04 e-27    ;0.000 000 000 95 e-27    ;kg
proton mass                                                 ;1.672 621 923 69 e-27    ;0.000 000 000 51 e-27    ;kg
tau mass                                                    ;3.167 54 e-27            ;0.000 21 e-27            ;kg
vacuum electric permittivity                                ;8.854 187 8128 e-12      ;0.000 000 0013 e-12      ;F m^-1
vacuum mag. permeability                                    ;1.256 637 062 12 e-6     ;0.000 000 000 19 e-6     ;N A^-2
electron volt                                               ;1.602 176 634 e-19       ;(exact)                  ;J
"
#%% /usr/local/var/pyenv/versions/3.8.6/lib/python3.8/site-packages/astropy/constants/iau2015.py
_iau2015 =
"
Astronomical Unit, 1.49597870700e11, 'm', 0.0,
Nominal solar mass parameter, 1.3271244e20, 'm3 / (s2)', 0.0,
Nominal solar radius, 6.957e8, 'm', 0.0,
Nominal Earth mass parameter, 3.986004e14, 'm3 / (s2)', 0.0,
Nominal Earth equatorial radius, 6.3781e6, 'm', 0.0,
"
codata2018 = _codata2018[2:end-1]
iau2015 = _iau2015[2:end-1]
#%%
function parse_constants_codata(data::String)
    constants = Dict{String,Tuple}()
    for line in split(data,  "\n")
        dlm = ";"
        lineWOdlm = split(line,dlm)
        name = rstrip(lineWOdlm[1])
        val = parse(Float64,replace(replace(lineWOdlm[2], " " => ""),"..."=>""))
        uncert = parse(Float64,replace(replace(lineWOdlm[3], "(exact)" => "0"), " "=>""))
        units = lineWOdlm[4]
        constants[name] = (val, units, uncert)
    end
    return (constants)
end
function parse_constants_iau(data::String)
    constants = Dict{String,Tuple}()
    for line in split(data,  "\n")
        dlm = ","
        lineWOdlm = split(line,dlm)
        name = rstrip(lineWOdlm[1])
        val = parse(Float64,replace(replace(lineWOdlm[2], " " => ""),"..."=>""))
        units = lstrip(replace(lineWOdlm[3],"'"=>""))
        uncert = parse(Float64,lineWOdlm[4])
        
        constants[name] = (val, units, uncert)
    end
    return (constants)
end
#%%

_physical_constants_2018 = parse_constants_codata(codata2018)
_iau_constants_2015 = parse_constants_iau(iau2015)
# all constants
physical_constants = Dict{String,Tuple}()
physical_constants = merge(physical_constants,_physical_constants_2018)
physical_constants = merge(physical_constants,_iau_constants_2015)
#%%

println(physical_constants)
function value(key::String)::Float64
    return physical_constants[key][1]
end
c = value("speed of light in vacuum")
N_A = NA = value("Avogadro constant")
k_B = kB =value("Boltzmann constant")
α = alpha = value("fine-structure constant")
R = value("molar gas constant")
G = value("Newtonian constant of gravitation")
h = value("Planck constant")
ħ = hbar = value("reduced Planck constant")
Rydberg = value("Rydberg constant")
m_e = me = value("electron mass")
m_μ = mμ = muon_mass = value("muon mass")
m_n = mn = value("neutron mass")
m_p = mp = value("proton mass")
m_τ = mτ = muon_tau = value("tau mass")
ε0 = epsilon_0 = value("vacuum electric permittivity")
μ0 = mu_0 = value("vacuum mag. permeability")

au = value("Astronomical Unit")
GM_sun = value("Nominal solar mass parameter")
R_sun = value("Nominal solar radius")
GM_earth = value("Nominal Earth mass parameter")
R_earth = value("Nominal Earth equatorial radius")