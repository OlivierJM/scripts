##trying scrapping with python3 and beautiful soup
from urllib.request import urlopen as uReq #import the url processing library
from bs4 import BeautifulSoup as soup #import beautiful  soup as soup

myUrl ="https://www.newegg.com/Video-Cards-Video-Devices/Category/ID-38?Tpk=graphics%20card"
uClient = uReq(myUrl) #get the html from the url
page_html = uClient.read()
uClient.read()
page_soup = soup(page_html, "html.parser") #pass and keep the html page in beautiful soup

#grabs all div with item-container as a class
containers = page_soup.findAll("div", {"class":"item-container"}) #access the html element with soup
#grab the title of the image
filename = "Product.csv" #create a file 
f = open(filename, "w") #open the file with write permission
headers = "brand, product_name, shipping\n" #add the headers to the csv file
f.write(headers) #write data from soup to the created csv file


#loop through all contents on that page with their specifiv elements or classes

for container in containers :
    brand =  container.div.div.a.img["title"]
    title_container = container.findAll("a", {"class": "item-title"})
    product_name = title_container[0].text
    shipping_container = container.findAll("li", {"class": "price-ship"})
    shipping = shipping_container[0].text.strip()

    print("brand: " + brand)
    print("product_name: " + product_name)
    print("shipping: " + shipping)

    f.write(brand + "," + product_name.replace("," , "|") + "," +  shipping + "\n")
f.close() #close the file
