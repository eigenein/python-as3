package game.data.storage.particle
{
   public class ParticleDataEntry
   {
       
      
      private var _ident:String;
      
      private var _pex:String;
      
      private var _textureAtlas:String;
      
      private var _textureRsxAsset:String;
      
      private var _textureName:String;
      
      public function ParticleDataEntry(param1:Object)
      {
         super();
         _ident = param1.ident;
         _pex = param1.pex;
         _textureName = param1.textureName;
         _textureRsxAsset = param1.textureRsxAsset;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function get pex() : String
      {
         return _pex;
      }
      
      public function get textureAtlas() : String
      {
         return _textureAtlas;
      }
      
      public function get textureRsxAsset() : String
      {
         return _textureRsxAsset;
      }
      
      public function get textureName() : String
      {
         return _textureName;
      }
   }
}
