package game.view.popup.mission
{
   import feathers.display.Scale3Image;
   import game.assets.storage.AssetStorage;
   import game.view.popup.common.PopupTitle;
   
   public class MissionEnterPopupTitle extends PopupTitle
   {
       
      
      private var _isElite:Boolean;
      
      public function MissionEnterPopupTitle(param1:Boolean, param2:String)
      {
         super(param2);
         this._isElite = param1;
      }
      
      public function get isElite() : Boolean
      {
         return _isElite;
      }
      
      public function set isElite(param1:Boolean) : void
      {
         _isElite = param1;
         if(isElite)
         {
            bg.textures = AssetStorage.rsx.popup_theme.getScale3Textures("header_evil_178_178_2",178,2);
            bg.y = -5;
         }
         else
         {
            bg.textures = AssetStorage.rsx.popup_theme.getScale3Textures("header_178_178_2",178,2);
            bg.y = 0;
         }
      }
      
      override protected function createBG() : void
      {
         if(_isElite)
         {
            bg = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("header_evil_178_178_2",178,2));
            bg.y = -5;
         }
         else
         {
            bg = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("header_178_178_2",178,2));
            bg.y = 0;
         }
         addChild(bg);
      }
   }
}
