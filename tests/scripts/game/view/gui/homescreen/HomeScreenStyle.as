package game.view.gui.homescreen
{
   import feathers.text.BitmapFontTextFormat;
   import feathers.textures.Scale3Textures;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.GameLabel;
   import game.view.popup.theme.LabelStyle;
   
   public class HomeScreenStyle
   {
      
      public static const IDENT:String = "main_screen";
      
      public static var textFormat:BitmapFontTextFormat;
      
      public static var labelBackgroundScale3Texture:Scale3Textures;
      
      private static var _initialized:Boolean;
      
      private static var _asset:RsxGuiAsset;
       
      
      public function HomeScreenStyle()
      {
         super();
      }
      
      public static function get asset() : RsxGuiAsset
      {
         return _asset;
      }
      
      public static function label_14() : GameLabel
      {
         var _loc1_:GameLabel = new GameLabel();
         _loc1_.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina14,14,16375461,"left");
         _loc1_.filter = LabelStyle.createDropShadowFilter();
         _loc1_.wordWrap = true;
         return _loc1_;
      }
      
      public static function initialize() : void
      {
         if(_initialized)
         {
            return;
         }
         _asset = AssetStorage.rsx.main_screen;
         _initialized = true;
      }
   }
}
