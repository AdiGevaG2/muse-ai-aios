# Source - SharePoint: Gal Sahar, "MCC Groups mapping.xlsx"

Captured: 2026-10-08 by Adi Geva, via the Microsoft 365 connector
Owner: Gal Sahar (Core group)

Two copies exist in Gal's OneDrive. Both were read in full.

| Copy | Path | Modified | Columns |
|---|---|---|---|
| A | `Documents/MCC score and UX/MCC Groups mapping.xlsx` | 2026-09-06 | Group Name, MCC, Name, plus an unlabeled note column |
| B | `Documents/MCC Groups mapping.xlsx` | 2026-09-02 | Same as A, plus a `Group Risk` column (F) |

Group membership is identical between the copies. The only difference is
copy B's `Group Risk` column.

Sheet: `Sheet1`, 1043 rows. Captured below as a faithful transcription: every
group, every non-brand code and name. The three brand-code blocks (hotel,
car-rental, airline brand codes, ~700 rows of brand names) are summarized by
code range; the full rows remain in the original workbook.

---

## Header and stand-alone block (verbatim)

Header row: `Group Name | MCC | Name`

Group Name cell for the first block, verbatim:
> Stand Alone Risky MCCs - these will each be their own "group" - other then the
> 5 highlighted MCCs ladder up "gambling" group

| MCC | Name | Col D | Col E (note) | Group Risk (copy B only) |
|---|---|---|---|---|
| 5967 | Inbound Teleservices (Direct Marketing) | | | |
| 7273 | Dating Services | | | |
| 7995 | Wagering and Betting | Gambling | Aligns with the way card brands view this activity (Visa for example associates them all with a version of "gambling" despite having separate MCCs to indicate the specific gambling activity/required licensure) | 5 |
| 7800 | Government Owned Lottery | | | |
| 7801 | Government-Licensed Casinos (Online or Internet Gambling) | | | |
| 7802 | Government-Licensed Horse/Dog Racing | | | |
| 9406 | Government-owned Lottery (global - other than US) | | | |
| 5912 | Drug Stores and Pharmacies | | | |
| 5122 | Drugs, Drug Proprietaries, Druggist Sundries | | | |
| 6051 | Quasi Cash (Non-Financial Institutions) | | | |
| 6012 | FI-Merchandise, Services, and Debt Repayment | | | |
| 4816 | Computer Network Services | | | |
| 5816 | Digital Goods - Games | | | |
| 6211 | Securities Brokers/Dealers | | | |
| 5966 | Outbound Telemarketing (Direct Marketing) | | | |
| 5968 | Continuity/Subscription Merchant (Direct Marketing) | | | |
| 5993 | Cigar Stores and Stands | | | |
| 7841 | Video Entertainment Rental Stores | | | |

Cell highlighting is not returned by the connector, so the "5 highlighted
MCCs" cannot be read directly.

## Business groups (codes and names verbatim, one line per group)

`Group Risk` values in copy B: Veterinary Services and Supplies = 1,
Agricultural Services and Supplies = 1. Every other group's cell is blank.

- **Veterinary Services and Supplies** - 0742 Veterinary Services; 5995 Pet Shops, Pet Food and Supplies
- **Agricultural Services and Supplies** - 0763 Agricultural Cooperatives; 0780 Horticultural and Landscaping Services; 4225 Public Warehousing–Farm Products, Refrigerated Goods, Household Goods Storage; 5992 Florists; 5261 Lawn and Garden Supply Stores; 5193 Florists Supplies, Nursery Stock and Flowers
- **Contractors** - 1520 General Contractors–Residential and Commercial; 1711 Air Conditioning, Heating and Plumbing Contractors; 1731 Electrical Contractors; 1740 Insulation, Masonry, Plastering, Stonework and Tile Setting Contractors; 1750 Carpentry Contractors; 1761 Roofing and Siding, Sheet Metal Work Contractors; 1771 Concrete Work Contractors; 1799 Contractors, Special Trade Contractors–not elsewhere classified; 8911 Architectural, Engineering and Surveying Services
- **Publishing** - 2741 Miscellaneous Publishing and Printing; 2791 Typesetting, Plate Making and Related Services; 5192 Books, Periodicals and Newspapers; 5942 Book Stores; 5994 News Dealers and Newsstands; 5973 Religious Goods Stores; 5946 Camera and Photographic Supply Stores; 7333 Commercial Art, Graphics, Photography; 7338 Quick Copy, Reproduction and Blueprinting Services; 7395 Photo Developing, Photofinishing Laboratories; 7221 Photographic Studios
- **Travel and Transportation** - 4011 Railroads–Freight; 4111 Transportation–Suburban and Local Commuter Passenger, including Ferries; 4112 Passenger Railways; 4119 Ambulance Services; 4121 Taxicabs and Limousines; 4131 Bus Lines; 4214 Motor Freight Carriers, Trucking–Local/Long Distance, Moving and Storage Companies, Local Delivery; 4215 Courier Services–Air and Ground, Freight Forwarders; 4411 Cruise Lines; 4457 Boat Leases and Boat Rentals; 4468 Marinas, Marine Service/Supplies; 4582 Airports, Airport Terminals, Flying Fields; 4784 Bridge and Road Fees, Tolls; 4789 Transportation Services Not Elsewhere Classified; 4722 Travel Agencies and Tour Operators; 4723 Package Tour Operators (Germany Only)
- **Telecommunication** - 4812 Telecommunication Equipment Including Telephone Sales; 4813 Key-Entry Telecom Merchant providing single local and long-distance phone calls using a central access number in a non-face-to-face environment using key entry; 4814 Telecommunication Services including but not limited to prepaid phone services and recurring phone services; 4821 Telegraph Services; 4829 Wire Transfer Money Orders (V, D, G, X) Money Transfer (M); 4899 Cable, Satellite, and Other Pay Television and Radio Services
- **Utilities** - 4900 Utilities–Electric, Gas, Heating Oil, Sanitary, Water
- **Industrial Products and Services** - 5085 Industrial Supplies Not Elsewhere Classified; 5039 Construction Materials Not Elsewhere Classified; 5046 Commercial Equipment Not Elsewhere Classified; 5051 Metal Service Centers and Offices; 5074 Plumbing and Heating Equipment; 5099 Durable Goods Not Elsewhere Classified; 5131 Piece Goods, Notions, and Other Dry Goods; 5169 Chemicals and Allied Products Not Elsewhere Classified; 5172 Petroleum and Petroleum Products
- **Cleaning Services** - 2842 Sanitation, Polishing and Specialty Cleaning Preparations; 7342 Exterminating and Disinfecting Services; 7349 Cleaning and Maintenance, Janitorial Services; 7210 Cleaning, Garment and Laundry Services; 7211 Laundry Services–Family and Commercial; 7216 Dry Cleaners; 7217 Carpet and Upholstery Cleaning; 7295 Housekeeping Service (China)
- **Digital Goods** - 5815 Digital Goods: Books, Movies, Music; 5817 Digital Goods: Applications (Excludes Games); 5818 Digital Goods: Large Digital Goods Merchant (V) Digital Goods: Multi-Category (M); 5735 Digital Goods: Record Stores
- **Software and Electronics** - 5045 Computers, Computer Peripheral Equipment, Software; 5065 Electrical Parts and Equipment; 5732 Electronics Sales; 5734 Computer Software Stores; 7622 Electronic Repair Shops; 7372 Computer Programming, Data Processing and Integrated System Design Services; 7379 Computer Maintenance, Repair And Services–Not Elsewhere Classified
- **Home and Hardware** - 5198 Paints, Varnishes and Supplies; 5199 Non-Durable Goods Not Elsewhere Classified; 5200 Home Supply Warehouse Stores; 5211 Building Materials, Lumber Stores; 5231 Glass, Paint, Wallpaper Stores; 5251 Hardware Stores; 5072 Hardware Equipment and Supplies; 5712 Equipment, Furniture and Home Furnishings Stores (except Appliances); 5713 Floor Covering Stores; 5714 Drapery, Upholstery and Window Coverings Stores; 5718 Fireplace, Fireplace Screens and Accessories Stores; 5719 Miscellaneous House Furnishing Specialty Shops; 5722 Household Appliance Stores; 5950 Crystal and Glassware Stores
- **Food and Beverage** - 5411 Grocery Stores, Supermarkets; 5422 Freezer and Locker Meat Provisioners; 5441 Candy, Nut and Confectionery Stores; 5451 Dairy Products Stores; 5499 Miscellaneous Food Stores–Convenience Stores, Markets, Specialty Stores, and Vending Machines; 5462 Bakeries; 5921 Package Stores–Beer, Wine and Liquor; 0743 Wine Producers; 0744 Champagne Producers; 5811 Caterers; 5812 Eating Places and Restaurants; 5813 Bars, Cocktail Lounges, Discotheques, Nightclubs and Taverns–Drinking Places (Alcoholic Beverages); 5814 Fast Food Restaurants
- **General Store** - 5300 Wholesale Clubs; 5309 Duty Free Stores; 5310 Discount Stores; 5311 Department Stores; 5331 Variety Stores; 5399 Miscellaneous General Merchandise Stores; 5262 Marketplaces
- **Auto Services and Supply** - 5013 Motor Vehicle Supplies and New Parts; 5511 Automobile and Truck Dealers–Sales, Service, Repairs, Parts and Leasing; 5521 Automobile and Truck Dealers–(Used Only)–Sales; 5532 Automotive Tire Stores; 5533 Automotive Parts and Accessories Stores; 5541 Service Stations (With or Without Ancillary Services); 5983 Fuel Dealers–Coal, Fuel Oil, Liquefied Petroleum, Wood; 5542 Fuel Dispenser, Automated; 5551 Boat Dealers; 5552 Electric Vehicle Charging; 5561 Camper Dealers, Recreational and Utility Trailers; 5571 Motorcycle Shops and Dealers; 5592 Motor Home Dealers; 5598 Snowmobile Dealers; 5599 Miscellaneous Automotive, Aircraft, and Farm Equipment Dealers–Not Elsewhere Classified; 5271 Mobile Home Dealers; 5531 Auto Store, Home Supply Stores; 7523 Automobile Parking Lots and Garages; 7531 Automotive Body Repair Shops; 7534 Tire Retreading and Repair Shops; 7535 Automotive Paint Shops; 7538 Automotive Service Shops; 7542 Car Washes; 5935 Wrecking and Salvage Yards; 7549 Towing Services
- **Fashion** - 5137 Men’s, Women’s and Children’s Uniforms and Commercial Clothing; 5139 Commercial Footwear; 5611 Men’s and Boys’ Clothing and Accessories Stores; 5621 Women’s Ready to Wear Stores; 5631 Women’s Accessory and Specialty Stores; 5641 Children’s and Infants’ Wear Stores; 5651 Family Clothing Stores; 5655 Sports Apparel, and Riding Apparel Stores; 5661 Shoe Stores; 5681 Furriers and Fur Shops; 5691 Men’s and Women’s Clothing Stores; 5697 Alterations, Mending, Seamstresses, Tailors; 5698 Wig and Toupee Shops; 5699 Accessory and Apparel Stores–Miscellaneous; 5948 Leather Goods and Luggage Stores; 5977 Cosmetic Stores; 7278 Buying/Shopping Clubs, Services; 7296 Clothing Rental–Costumes, Uniforms and Formal Wear; 7251 Hat Cleaning Shops, Shoe Repair Shops, Shoe Shine Parlors; 5997 Electric Razor Stores–Sales and Service
- **Precious Metals and Jewelry** - 5944 Clock, Jewelry, Watch and Silverware Stores; 5094 Precious Stones and Metals, Watches and Jewelry; 7631 Clock, Jewelry and Watch Repair Shops
- **Marketing and Advertising** - 7311 Advertising Services; 7392 Consulting, Management and Public Relations Services; 5961 Mail Order Houses Including Catalog Order Stores; 5962 Direct Marketing - Travel-Related Arrangement Services via outbound telemarketing; 5964 Direct Marketing–Catalog Merchants; 5965 Direct Marketing–Combination Catalog and Retail Merchant; 5969 Direct Marketing–Other Direct Marketers–Not Elsewhere Classified; 5963 Door-to-Door Sales
- **Office Supply and Business Support** - 5021 Office and Commercial Furniture; 5044 Office, Photographic, Photocopy and Microfilm Equipment; 5111 Stationery, Office Supplies, Printing and Writing Paper; 5943 Office, School Supply and Stationery Stores; 5978 Typewriter Stores–Rentals, Sales, Service; 7339 Stenographic and Secretarial Support Services; 7361 Employment Agencies and Temporary Help Services; 7375 Information Retrieval Services; 7393 Detective Agencies, Protective Agencies, Security Services including Armored Cars, Guard Dogs; 7394 Equipment Rental and Leasing Services, Furniture Rental, Tool Rental; 7399 Business Services Not Elsewhere Classified; 8734 Testing Laboratories (Non-Medical); 8999 Professional Services–Not Elsewhere Classified
- **Legal and Finance** - 8111 Attorneys, Legal Services; 7277 Debt, Marriage, Personal–Counseling Services; 8931 Accounting, Auditing and Bookkeeping Services; 7276 Tax Preparation Service; 7321 Consumer Credit Reporting Agencies; 7322 Debt Collection Agencies; 9223 Bail and Bond Payments
- **Repair Shops** - 7623 Air Conditioning and Refrigeration Repair Shops; 7629 Appliance Repair Shops, Electrical and Small; 7641 Furniture–Reupholstery, Repair and Refinishing; 7692 Welding Repair; 7699 Miscellaneous Repair Shops and Related Services
- **Entertainment and Amusement** - 7032 Sporting and Recreational Camps; 7829 Motion Picture and Video Tape Production and Distribution; 7832 Motion Picture Theaters; 7911 Dance Halls, Schools and Studios; 7922 Theatrical Producers (Except Motion Pictures), Ticket Agencies; 7929 Bands, Orchestras and Miscellaneous Entertainers– Not Elsewhere Classified; 7932 Pool and Billiard Establishments; 7933 Bowling Alleys; 7941 Athletic Fields, Commercial Sports, Professional Sports Clubs, Sports Promoters; 7991 Tourist Attractions and Exhibits; 7992 Golf Courses, Public; 7993 Video Amusement Game Supplies; 7994 Video Game Arcades and Establishments; 7996 Amusement Parks, Carnivals, Circuses, Carnivals, Fortune Tellers; 7997 Clubs–Country Clubs, Membership (Athletic, Recreation, Sports), Private Golf Courses; 7998 Aquariums, Dolphinariums, Zoos and Seaquariums; 7999 Recreation Services–Not Elsewhere Classified; 5733 Music Stores–Musical Instruments, Pianos and Sheet Music
- **Health Services and Supply** - 8011 Doctors–not elsewhere classified; 8021 Dentists and Orthodontists; 8031 Osteopathic Physicians; 8041 Chiropractors; 8042 Optometrists and Ophthalmologists; 8043 Opticians, Optical Goods and Eyeglasses; 8049 Chiropodists, Podiatrists; 8050 Nursing and Personal Care Facilities; 8062 Hospitals; 8071 Dental and Medical Laboratories; 8099 Health Practitioners, Medical Services–Not Elsewhere Classified; 5047 Dental/Laboratory/Medical/Ophthalmic Hospital Equipment and Supplies; 5975 Hearing Aids–Sales, Service, Supply Stores; 5976 Orthopedic Goods–Artificial Limb Stores; 7297 Massage Parlors
- **Educational Institutions** - 8241 Schools, Correspondence; 8244 Schools, Business and Secretarial; 8249 Schools, Trade and Vocational; 8211 Schools, Elementary and Secondary; 8220 Colleges, Universities, Professional Schools and Junior Colleges; 8299 Schools And Educational Services–Not Elsewhere Classified; 8351 Child Care Services
- **Charities and Associations** - 8398 Organizations, Charitable and Social Service; 8641 Associations–Civic, Social and Fraternal; 8651 Organizations, Political; 8661 Organizations, Religious; 8675 Automobile Associations; 8699 Organizations, Membership–Not Elsewhere Classified
- **Government Services** - 9402 Postal Services–Government Only; 9222 Fines; 9211 Court Costs Including Alimony and Child Support; 9311 Tax Payments; 9399 Government Services–Not Elsewhere Classified; 9405 Intra-Government Purchases–Government Only; 9700 Automated Referral Service; 9701 Visa Credential Server; 9702 GCAS Emergency Services; 9950 Intra-Company Purchases
- **Insurance** - 5960 Direct Marketing Insurance Services; 6300 Insurance Sales, Underwriting and Premiums
- **Sporting Goods** - 5940 Bicycle Shops–Sales and Service; 5941 Sporting Goods Stores; 5996 Swimming Pools–Sales and Supplies; 5998 Tent and Awning Shops; 5999 Miscellaneous and Specialty Retail Stores; 5723 Guns and Ammunition Shops
- **Art and Hobby Shops** - 5945 Game, Toy and Hobby Shops; 5947 Card, Gift, Novelty and Souvenir Shops; 5949 Fabric, Needlework, Piece Goods and Sewing Stores; 5970 Artist Supply Stores, Craft Shops; 5971 Art Dealers and Galleries; 5972 Stamp and Coin Stores–Philatelic and Numismatic Supplies
- **Antiques and Second Hand Goods** - 5931 Second Hand Stores, Used Merchandise Stores; 5932 Antique Shops–Sales, Repairs and Restoration Services; 5933 Pawn Shops; 5937 Antique Reproduction Stores
- **Unique Merchants** - 7299 Other Services–Not Elsewhere Classified
- **Money and Financial Services** - 6010 Member Financial Institution–Manual Cash Disbursements; 6011 Member Financial Institution–Automated Cash Disbursements; 6050 Quasi Cash–Member Financial Institution; 6536 MoneySend Intracountry; 6537 MoneySend Intercountry; 6538 MoneySend Funding; 6539 Funding Transaction (Excluding MoneySend); 6540 POI (Point of Interaction) Funding Transactions (Excluding MoneySend); 6532 Payment Service Provider - Member FI; 6533 Payment Service Provider - Merchant
- **Funeral Services** - 7261 Funeral Service and Crematories
- **Spa and Salon Establishments** - 7230 Barber and Beauty Shops; 7298 Health and Beauty Spas
- **Real Estate and Rental Lodging** - 7012 Timeshares; 7033 Campgrounds and Trailer Parks; 6513 Real Estate Agents and Managers–Rentals; 7011 Lodging–Hotels, Motels, Resorts–not elsewhere classified
- **Hotels and Casinos** - brand codes 3501 Holiday Inn Express through 3839 Kyoritsu Hotels, contiguous. Includes casino-hotel brands, e.g. 3551 Mirage Hotel And Casino, 3596 Wynn Las Vegas, 3731 Harrahs Hotels And Casinos, 3765 Bellagio, 3771 Caesars Hotel And Casino. No generic lodging code in this group (7011 sits in Real Estate and Rental Lodging).
- **Auto Rental** - 7513 Truck Rental; 7519 Motor Home and Recreational Vehicle Rental; brand codes 3351 Affiliated Auto Rental through 3441 Advantage Rent A Car; 7512 Automobile Rental Agency-Not Elsewhere Classified
- **Airlines** - 4511 Air Carriers, Airlines-not elsewhere classified; brand codes 3000 United Airlines through 3303 Tigerair, then 3308 China Southern Airlines (last row of the sheet). 3281 is absent from the sequence.
