package  {
	
	import com.hurlant.util.Hex;
	import flash.utils.ByteArray;
	
	public class dec {

		public function dec() {
			// constructor code
			
		}
		
		public function encodeUnsignedDec(p1:String,p2:String):ByteArray{
			
			var decByteArray:ByteArray= new ByteArray()
			
			decByteArray.writeBytes(Hex.toArray(Hex.fromString(p1)))
			
			decByteArray.writeByte(0xEE)
			decByteArray.writeByte(0xEE)
			decByteArray.writeByte(0xEE)
			decByteArray.writeByte(0xEE)
			
			decByteArray.writeBytes(Hex.toArray(Hex.fromString(p2)))
			
			return decByteArray
		}
		
		public function encodeAcceptRespond(signature:ByteArray, pubKey:ByteArray):ByteArray{
			
			var respondByteArray:ByteArray= new ByteArray()
			
			respondByteArray.writeBytes(signature)
			
			respondByteArray.writeByte(0xDD)
			respondByteArray.writeByte(0xDD)
			respondByteArray.writeByte(0xDD)
			respondByteArray.writeByte(0xDD)
			
			respondByteArray.writeBytes(pubKey)
			
			return respondByteArray
		}
		
		public function combinesDecs(sDec1:ByteArray, sDec2:ByteArray):ByteArray{
			
			var respondByteArray:ByteArray= new ByteArray()
			
			respondByteArray.writeBytes(sDec1)
			
			respondByteArray.writeByte(0xBB)
			respondByteArray.writeByte(0xBB)
			respondByteArray.writeByte(0xBB)
			respondByteArray.writeByte(0xBB)
			respondByteArray.writeByte(0xBB)
			
			respondByteArray.writeBytes(sDec2)
			
			return respondByteArray
		}
		
		
		public function finalizeDec(rawDec:ByteArray, signDec:ByteArray):ByteArray{
			
			var respondByteArray:ByteArray= new ByteArray()
			
			respondByteArray.writeBytes(rawDec)
			
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			respondByteArray.writeByte(0xFF)
			
			respondByteArray.writeBytes(signDec)
			
			return respondByteArray
		}

	}
	
}
