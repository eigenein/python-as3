package engine.core.assets
{
   import game.assets.storage.rsx.RsxGuiAsset;
   
   public class AssetList implements RequestableAsset
   {
       
      
      private var _completed:Boolean;
      
      private var _assets:Array;
      
      private var usageAdded:Boolean = false;
      
      public function AssetList()
      {
         _assets = [this];
         super();
      }
      
      public function dropUsage() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addAssets(... rest) : void
      {
         if(usageAdded)
         {
            return;
         }
         _assets = _assets.concat(rest);
      }
      
      public function prepare(param1:AssetProvider) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function complete() : void
      {
         _completed = true;
      }
   }
}
