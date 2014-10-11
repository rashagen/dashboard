Schemas = {}

Schemas.DummyNodes = new SimpleSchema(

  network:
    type: String
    allowedValues: [
      "Bitcoin"
      "Exchange"
      "BankAccount"
    ]
  nodeId:
    type: String
    optional: true
  name:
    type:String

)



Schemas.User = new SimpleSchema(


  emails:
    type: [Object]

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email
    label: 'E-Mail Address'


  "emails.$.verified":
    type: Boolean
    optional: true

  createdAt:
    optional: true
    type: Date

  profile:
    type: Schemas.profile
    label: 'Profile'
    optional:true

  services:
    type: Object
    optional: true
    blackbox: true

  dummyNodes:
    type:[Schemas.DummyNodes]
    label:'DummyNodes'


#  'dummyNodes.$.network':
#    type: String
#    allowedValues: [
#      "Bitcoin"
#      "Exchange"
#      "BankAccount"
#    ]
#
#  'dummyNodes.$.nodeId':
#    type: String
#    optional: true
#
#  'dummyNodes.$.name':
#    type:String





)



Meteor.users.attachSchema Schemas.User







Schemas.profile = new SimpleSchema(


  firstName:
    type: String
    optional: true
    max: 28
    label: 'Vorname'

  lastName:
    type: String
    max: 28
    optional: true
    label: 'Nachname'

  birthday:
    type: Date
    max: new Date '2014-01-01'
    optional: true
    label: 'Geburtstag'




  gender:
    type: String
    optional: true
    label: 'Geschlecht'

    allowedValues: [
      'm'
      'f'
      'unknown'
    ]
    autoform:
      options: ->
        [
          {label: '',value:'unknown'}

          {label: 'männlich',value:'m'}
          {label: 'weiblich',value:'f'}
        ]

  street:
    type: String
    optional: true
    label: 'Straße'

  houseNumber:
    type: String
    optional: true
    label: 'Hausnummer'

  postcode:
    type: String
    optional: true
    label: 'Postleitzahl'
    regEx: /^([0-9]{0,5})$/

  city:
    type: String
    optional: true
    label: 'Stadt'



  public:
    type: Boolean
    optional: true

#    autoValue: ->
#      if this.isInsert
#        false

  profilePicture:
    type: String
    label: "Foto"
    optional: true




  country:
    type: String
    label: 'Land'


    allowedValues: [
      "Afghanistan"
      "Alandinseln"
      "Albanien"
      "Algerien"
      "Amerikanisch-Ozeanien"
      "Amerikanisch-Samoa"
      "Amerikanische Jungferninseln"
      "Andorra"
      "Angola"
      "Anguilla"
      "Antarktis"
      "Antigua und Barbuda"
      "Argentinien"
      "Armenien"
      "Aruba"
      "Aserbaidschan"
      "Australien"
      "Bahamas"
      "Bahrain"
      "Bangladesch"
      "Barbados"
      "Belarus"
      "Belgien"
      "Belize"
      "Benin"
      "Bermuda"
      "Bhutan"
      "Bolivien"
      "Bosnien und Herzegowina"
      "Botsuana"
      "Bouvetinsel"
      "Brasilien"
      "Britische Jungferninseln"
      "Britisches Territorium im Indischen Ozean"
      "Brunei Darussalam"
      "Bulgarien"
      "Burkina Faso"
      "Burundi"
      "Chile"
      "China"
      "Cookinseln"
      "Costa Rica"
      "Côte d’Ivoire"
      "Demokratische Republik Kongo"
      "Demokratische Volksrepublik Korea"
      "Deutschland"
      "Dominica"
      "Dominikanische Republik"
      "Dschibuti"
      "Dänemark"
      "Ecuador"
      "El Salvador"
      "Eritrea"
      "Estland"
      "Falklandinseln"
      "Fidschi"
      "Finnland"
      "Frankreich"
      "Französisch-Guayana"
      "Französisch-Polynesien"
      "Französische Süd- und Antarktisgebiete"
      "Färöer"
      "Gabun"
      "Gambia"
      "Georgien"
      "Ghana"
      "Gibraltar"
      "Grenada"
      "Griechenland"
      "Grönland"
      "Guadeloupe"
      "Guam"
      "Guatemala"
      "Guernsey"
      "Guinea"
      "Guinea-Bissau"
      "Guyana"
      "Haiti"
      "Heard- und McDonald-Inseln"
      "Honduras"
      "Indien"
      "Indonesien"
      "Irak"
      "Iran"
      "Irland"
      "Island"
      "Isle of Man"
      "Israel"
      "Italien"
      "Jamaika"
      "Japan"
      "Jemen"
      "Jersey"
      "Jordanien"
      "Kaimaninseln"
      "Kambodscha"
      "Kamerun"
      "Kanada"
      "Kap Verde"
      "Kasachstan"
      "Katar"
      "Kenia"
      "Kirgisistan"
      "Kiribati"
      "Kokosinseln"
      "Kolumbien"
      "Komoren"
      "Kongo"
      "Kroatien"
      "Kuba"
      "Kuwait"
      "Laos"
      "Lesotho"
      "Lettland"
      "Libanon"
      "Liberia"
      "Libyen"
      "Liechtenstein"
      "Litauen"
      "Luxemburg"
      "Madagaskar"
      "Malawi"
      "Malaysia"
      "Malediven"
      "Mali"
      "Malta"
      "Marokko"
      "Marshallinseln"
      "Martinique"
      "Mauretanien"
      "Mauritius"
      "Mayotte"
      "Mazedonien"
      "Mexiko"
      "Mikronesien"
      "Monaco"
      "Mongolei"
      "Montenegro"
      "Montserrat"
      "Mosambik"
      "Myanmar"
      "Namibia"
      "Nauru"
      "Nepal"
      "Neukaledonien"
      "Neuseeland"
      "Nicaragua"
      "Niederlande"
      "Niederländische Antillen"
      "Niger"
      "Nigeria"
      "Niue"
      "Norfolkinsel"
      "Norwegen"
      "Nördliche Marianen"
      "Oman"
      "Osttimor"
      "Pakistan"
      "Palau"
      "Palästinensische Gebiete"
      "Panama"
      "Papua-Neuguinea"
      "Paraguay"
      "Peru"
      "Philippinen"
      "Pitcairn"
      "Polen"
      "Portugal"
      "Puerto Rico"
      "Republik Korea"
      "Republik Moldau"
      "Ruanda"
      "Rumänien"
      "Russische Föderation"
      "Réunion"
      "Salomonen"
      "Sambia"
      "Samoa"
      "San Marino"
      "Saudi-Arabien"
      "Schweden"
      "Schweiz"
      "Senegal"
      "Serbien"
      "Serbien und Montenegro"
      "Seychellen"
      "Sierra Leone"
      "Simbabwe"
      "Singapur"
      "Slowakei"
      "Slowenien"
      "Somalia"
      "Sonderverwaltungszone Hongkong"
      "Sonderverwaltungszone Macao"
      "Spanien"
      "Sri Lanka"
      "St. Barthélemy"
      "St. Helena"
      "St. Kitts und Nevis"
      "St. Lucia"
      "St. Martin"
      "St. Pierre und Miquelon"
      "St. Vincent und die Grenadinen"
      "Sudan"
      "Suriname"
      "Svalbard und Jan Mayen"
      "Swasiland"
      "Syrien"
      "São Tomé und Príncipe"
      "Südafrika"
      "Südgeorgien und die Südlichen Sandwichinseln"
      "Tadschikistan"
      "Taiwan"
      "Tansania"
      "Thailand"
      "Togo"
      "Tokelau"
      "Tonga"
      "Trinidad und Tobago"
      "Tschad"
      "Tschechische Republik"
      "Tunesien"
      "Turkmenistan"
      "Turks- und Caicosinseln"
      "Tuvalu"
      "Türkei"
      "Uganda"
      "Ukraine"
      "Unbekannte oder ungültige Region"
      "Ungarn"
      "Uruguay"
      "Usbekistan"
      "Vanuatu"
      "Vatikanstadt"
      "Venezuela"
      "Vereinigte Arabische Emirate"
      "Vereinigte Staaten"
      "Vereinigtes Königreich"
      "Vietnam"
      "Wallis und Futuna"
      "Weihnachtsinsel"
      "Westsahara"
      "Zentralafrikanische Republik"
      "Zypern"
      "Ägypten"
      "Äquatorialguinea"
      "Äthiopien"
      "Österreich"
    ]
    optional: true

    autoValue: ->
      if this.isInsert
        'Deutschland'
    autoform:
      type: 'select'
)








