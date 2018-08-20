package game.assets.battle
{
   import com.progrestar.framework.ares.core.Clip;
   import engine.core.clipgui.IGuiClip;
   import game.assets.storage.RsxGameAsset;
   import game.assets.storage.rsx.RsxGuiAsset;
   
   public class AssetClipLink
   {
       
      
      private var _asset:RsxGameAsset;
      
      private var _clip:String;
      
      public function AssetClipLink(param1:RsxGameAsset, param2:String)
      {
         super();
         this._asset = param1;
         this._clip = param2;
      }
      
      public function get asset() : RsxGameAsset
      {
         return _asset;
      }
      
      public function get completed() : Boolean
      {
         return _asset != null && _asset.completed;
      }
      
      public function get clip() : Clip
      {
         return _asset.data.getClipByName(_clip);
      }
      
      public function get clipName() : String
      {
         return _clip;
      }
      
      public function createGuiClip(param1:Class) : *
      {
         if(_asset is RsxGuiAsset)
         {
            return (_asset as RsxGuiAsset).create(param1,_clip);
         }
         return null;
      }
      
      public function initGuiClip(param1:IGuiClip) : void
      {
         if(_asset is RsxGuiAsset)
         {
            (_asset as RsxGuiAsset).initGuiClip(param1,_clip);
         }
      }
   }
}
