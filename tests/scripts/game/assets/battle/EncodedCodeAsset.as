package game.assets.battle
{
   import by.blooddy.crypto.CRC32;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.RequestableAsset;
   import engine.core.assets.file.RawDataFile;
   import flash.utils.ByteArray;
   import game.assets.GameAsset;
   import game.assets.storage.AssetStorage;
   
   public class EncodedCodeAsset extends GameAsset implements RequestableAsset
   {
       
      
      private var codeBytesFile:RawDataFile;
      
      private var _hash:uint;
      
      public var codeBytes:ByteArray;
      
      public function EncodedCodeAsset(param1:String)
      {
         super(param1);
         codeBytesFile = getDataFile(param1);
         codeBytesFile.doNotCheckFileSizeAnyMore();
      }
      
      override public function get completed() : Boolean
      {
         return codeBytes != null;
      }
      
      public function get hash() : uint
      {
         return _hash;
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,codeBytesFile);
      }
      
      override public function complete() : void
      {
         codeBytes = codeBytesFile.bytes;
         _hash = CRC32.hash(codeBytes);
         AssetStorage.battle.loadEncodedCode(codeBytes);
         codeBytesFile.dispose();
      }
   }
}
