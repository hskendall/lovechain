﻿package  {
	
	import dec
	import org.qrcode.QRCode;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import flash.text.Font;
	import flash.text.TextFormat;
	//import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	
	//------------------------------------------------------------------------------ import Scroller
	import com.doitflash.events.ScrollEvent;
	import com.doitflash.consts.Orientation;
	import com.doitflash.utils.scroll.TouchScroll;
	//import com.doitflash.utils.scroll.MouseScroll;
	import com.doitflash.consts.Easing;
	import com.doitflash.consts.ScrollConst;
	
	
	
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.SharedObject
	import com.hurlant.util.Hex;
	import flash.utils.ByteArray;
	import deriveAddress
	import com.king.encoder.RippleBase58Encoder;
	import flame.utils.ByteArrayUtil;
	import rippleFamily
	import flame.crypto.ECCParameters
    import flame.crypto.ECDSA
    import flame.crypto.asn1.ASN1BMPString
	import com.adobe.crypto.SHA256;
	import com.hurlant.util.der.ByteString
	import com.hurlant.util.der.DER
	import com.hurlant.util.der.IAsn1Type
	import com.hurlant.util.der.Integer;
	import flame.numerics.BigInteger;
	import encodeSig
    import generateTX
	import checkAddress
	import flash.display.Stage
	import com.king.encoder.Base58Encoder;
	import encodeKeys

	
	
	public class hackathon extends MovieClip {
		


	public var logInfo:SharedObject
	public var walletInfo:SharedObject
	public var keyData:ECCParameters= new ECCParameters()
		
	public var decClass:dec= new dec()
	public var encodeSigClass:encodeSig= new encodeSig()
	public var generateTXClass:generateTX= new generateTX()
	public var ECDSAclass:ECDSA = new ECDSA()
	public var deriveAddressClass:deriveAddress= new deriveAddress()
    public var rippleFamilyClass:rippleFamily= new rippleFamily()
	public var checkAddressClass:checkAddress= new checkAddress()
	public var encodeKeysClass:encodeKeys= new encodeKeys()
	
    public var localCurrency:String= "USD"
	public var cryptocurrencyNameArray:Array= new Array("Bitcoin", "Ethereum", "Litecoin", "Ripple", "Dash", "Z-Cash" , "Dogecoin");
	public var cryptocurrencySymbolArray:Array= new Array("BTC", "ETH", "LTC", "XRP", "DASH", "ZEC", "DOGE");
		
	public var TXInput_txid:Array = new Array()
	public var TXInput_vout:Array = new Array()
	public var TXOutput_amount:Array = new Array()
	public var TXOutput_address:Array = new Array()
		
		
		public function hackathon() {
					
			init()
			
			//generateRawTX()
			
			//logWallet()
			
			//stage.addEventListener("click", demof)
			
			//trace(generateWalletClass.bitcoinPrivateKey)
			
		}

		public function init() {
			
			///trace("AS: "+checkAddressClass.check("Xv7XoS24ztvmTi5JqM8JM2emoLwLtXzrs3"))
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
			
			
			//Importing wallet files from wallet's local memory.
			//Yerel hafızadan cüzdan bilgilerini çekiyoruz.
			logInfo = SharedObject.getLocal("logInfo");
			walletInfo = SharedObject.getLocal("walletInfo");
			
	        //ECDSAclass.deriveCorrespondingPubkey2(walletInfo.data.keyData.d)
            trace("PRI: "+walletInfo.data.privateKey)
			trace("pri2: "+Hex.fromArray(walletInfo.data.keyData.d))
			
		var ecdsa:ECDSA = new ECDSA(256);
		ecdsa.deriveCorrespondingPubkey2(walletInfo.data.keyData.d)

			//Getting recent exchange rates.
			//Güncel kur bilgilerini çekiyoruz.
			//getExchangeRateClass.init(localCurrency)			
			
			if(logInfo.data.logBoo==true){
			//this.logWallet()
			this.gotoAndStop(2)
			}
			
			else {
			this.gotoAndStop(1)
			}
			
		
		}
		
		
		public function logPrivateKey(privateKey1:String,privateKey2:String,privateKey3:String,privateKey4:String,privateKey5:String) {
			
			walletInfo.data.bitcoinPrivateKey= privateKey1
			
			walletInfo.data.bitcoinPublicKey= "04" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey1),1)) + String(ECDSAclass.getPubKey(Hex.toArray(privateKey1),2))
			
			walletInfo.data.bitcoinCompressedPublicKey= "03" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey1),1))
			
			walletInfo.data.bitcoinPKH= deriveAddressClass.derivePubKeyHash(Hex.toArray(walletInfo.data.bitcoinPublicKey))

			walletInfo.data.bitcoinAddress= deriveAddressClass.deriveBitcoinAddress(Hex.toArray(walletInfo.data.bitcoinPublicKey))
			
			////////
			/*
			walletInfo.data.ethereumPrivateKey= privateKey2
			walletInfo.data.ethereumPriKey= privateKey2
			
			walletInfo.data.ethereumPublicKey= "04" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey2),1)) + String(ECDSAclass.getPubKey(Hex.toArray(privateKey2),2))
			
			walletInfo.data.ethereumCompressedPublicKey= "03" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey2),1))
			
			walletInfo.data.ethereumPKH= deriveAddressClass.derivePubKeyHash(Hex.toArray(walletInfo.data.ethereumPublicKey))
			
			walletInfo.data.ethereumAddress= ""
			*/
			
			getEthWallet()
			
			////////
			
			walletInfo.data.litecoinPrivateKey= privateKey3
			
			walletInfo.data.litecoinPublicKey= "04" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey3),1)) + String(ECDSAclass.getPubKey(Hex.toArray(privateKey3),2))
			
			walletInfo.data.litecoinCompressedPublicKey= "03" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey3),1))
			
			walletInfo.data.litecoinPKH= deriveAddressClass.derivePubKeyHash(Hex.toArray(walletInfo.data.litecoinPublicKey))
			
			walletInfo.data.litecoinAddress= deriveAddressClass.deriveLitecoinAddress(Hex.toArray(walletInfo.data.litecoinPublicKey))
			
			////////
			
			walletInfo.data.dashPrivateKey= privateKey4
			
			walletInfo.data.dashPublicKey= "04" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey4),1)) + String(ECDSAclass.getPubKey(Hex.toArray(privateKey4),2))
			
			walletInfo.data.dashCompressedPublicKey= "03" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey4),1))
			
			walletInfo.data.dashPKH= deriveAddressClass.derivePubKeyHash(Hex.toArray(walletInfo.data.dashPublicKey))
			
			walletInfo.data.dashAddress= deriveAddressClass.deriveDashAddress(Hex.toArray(walletInfo.data.dashPublicKey))
			
			////////
			
			walletInfo.data.dogecoinPrivateKey= privateKey5
			
			walletInfo.data.dogecoinPublicKey= "04" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey5),1)) + String(ECDSAclass.getPubKey(Hex.toArray(privateKey5),2))
			
			walletInfo.data.dogecoinCompressedPublicKey= "03" + String(ECDSAclass.getPubKey(Hex.toArray(privateKey5),1))
			
			walletInfo.data.dogecoinPKH= deriveAddressClass.derivePubKeyHash(Hex.toArray(walletInfo.data.dogecoinPublicKey))
			
			walletInfo.data.dogeAddress= deriveAddressClass.deriveDogeAddress(Hex.toArray(walletInfo.data.dogecoinPublicKey))
			
			////////
			
		}

		
		

		
		
		public function generateWallet():void {
			
			var privateKey:ByteArray = new ByteArray();
			var publicKey:ByteArray = new ByteArray();
			var compressedPublicKey:ByteArray = new ByteArray();
	    
			//Calling "exportParameters" function from ECDSA class to generate unique corresponding ECDSA keypairs.
        	//İlgili ECDSA anahtar çiftlerini oluşturmak için ECDSA sınıfından "exportParameters" fonksiyonunu çağırıyoruz.
        	keyData= ECDSAclass.exportParameters(true)
			

			//Initializing public key by adding related prefix.
			//Açık anahtarımıza ilgili ön ekini ekliyoruz.
			publicKey.writeByte(0x04);
			compressedPublicKey.writeByte(0x03);
			
			//Deriving public key from x,y parameters.
			//Açık anahtarımızı ECDSA x,y parametlerine dayanarak türetiyoruz.
			privateKey.writeBytes(keyData.d); //.d
			publicKey.writeBytes(keyData.x); //.x
			publicKey.writeBytes(keyData.y); //.y
			compressedPublicKey.writeBytes(keyData.x);
			
			privateKey.position= 0
			publicKey.position= 0
			compressedPublicKey.position= 0
			
			
		
			//Assigning keypairs to the local wallet memory.
			//Anahtar ikililerini cüzdan yerel hafızasına atıyoruz.
			walletInfo.data.publicKey= Hex.fromArray(publicKey)
			walletInfo.data.pkh= deriveAddressClass.derivePubKeyHash(publicKey)
			trace("amqbe: "+walletInfo.data.pkh)
			walletInfo.data.privateKey= Hex.fromArray(privateKey)
			walletInfo.data.compressedPublicKey= Hex.fromArray(compressedPublicKey)
			
			walletInfo.data.keyData= keyData
			
			trace("PRIKEYIS: "+walletInfo.data.privateKey)
			trace("PUBKEYIS: "+walletInfo.data.publicKey)
			
			
		
		
			//Deriving cryptocurrency addresses from single ECDSA public key.
			//Adresleri tek bir ECDSA anahtarı üzerinden türetiyoruz.
			walletInfo.data.bitcoinAddress= deriveAddressClass.deriveBitcoinAddress(publicKey)
			walletInfo.data.litecoinAddress= deriveAddressClass.deriveLitecoinAddress(publicKey)
			walletInfo.data.dashAddress= deriveAddressClass.deriveDashAddress(publicKey)
			walletInfo.data.dogeAddress= deriveAddressClass.deriveDogeAddress(publicKey)
			walletInfo.data.zcashAddress= deriveAddressClass.deriveZCashAddress(publicKey)
			//walletInfo.data.ethereumAddress= deriveAddressClass.deriveEthereumAddress(compressedPublicKey)
			walletInfo.data.rippleAddress= deriveAddressClass.deriveRippleAddress(compressedPublicKey)
			//walletInfo.data.neoAddress= deriveAddressClass.deriveNeoAddress(publicKey)
			
			walletInfo.data.pubKeyHash= deriveAddressClass.derivePubKeyHash(publicKey)
			
			
			walletInfo.data.bitcoinPrivateKey= walletInfo.data.privateKey
			walletInfo.data.litecoinPrivateKey= walletInfo.data.privateKey
			walletInfo.data.ethereumPrivateKey= walletInfo.data.privateKey
			walletInfo.data.dashPrivateKey= walletInfo.data.privateKey
			walletInfo.data.dogecoinPrivateKey= walletInfo.data.privateKey
			
			
			walletInfo.data.bitcoinPublicKey= walletInfo.data.publicKey
			walletInfo.data.litecoinPublicKey= walletInfo.data.publicKey
			walletInfo.data.ethereumPublicKey= walletInfo.data.publicKey
			walletInfo.data.dashPublicKey= walletInfo.data.publicKey
			walletInfo.data.dogecoinPublicKey= walletInfo.data.publicKey
			
			
			walletInfo.data.bitcoinCompressedPublicKey= walletInfo.data.compressedPublicKey
			walletInfo.data.litecoinCompressedPublicKey= walletInfo.data.compressedPublicKey
			walletInfo.data.ethereumCompressedPublicKey= walletInfo.data.compressedPublicKey
			walletInfo.data.dashCompressedPublicKey= walletInfo.data.compressedPublicKey
			walletInfo.data.dogecoinCompressedPublicKey= walletInfo.data.compressedPublicKey
			
			
			walletInfo.data.bitcoinPKH= walletInfo.data.pkh
			walletInfo.data.litecoinPKH= walletInfo.data.pkh
			walletInfo.data.ethereumPKH= walletInfo.data.pkh
			walletInfo.data.dashPKH= walletInfo.data.pkh
			walletInfo.data.dogecoinPKH= walletInfo.data.pkh
			
			
			logInfo.data.logBoo= true
		
			walletInfo.flush()
			logInfo.flush()
		
		}

		public function generateRawTX(TXInput_txid:Array,TXInput_vout:Array,TXOutput_amounts:Array,TXOutput_address:Array):String {
			
			
			//TXInput_txid.push()
			//TXInput_vout.push()
			//TXOutput_amount.push()
			//TXOutput_address.push()
			
			//Calling "generateUnsignedTX" function from generateTX class to encoude unsigned hex TX by given related parameters.
			//Hex formatında imzalanmamış bir işlem oluşturmak için ilgili paramatreleri girerek generateTX sınıfından "generateUnsignedTX" fonksiyonunu çağırıyoruz.
			return generateTXClass.generateUnsignedTX(TXInput_txid, TXInput_vout, TXOutput_amounts, TXOutput_address, walletInfo.data.publicKey)
			
		}
		
		
        public function decodeAddress(address:String):String {
			return(           Hex.fromArray(Base58Encoder.decode( address) )          )
		}
		
		
		
		
		
		
	}
	
}
