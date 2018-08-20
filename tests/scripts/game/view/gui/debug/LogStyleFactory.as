package game.view.gui.debug
{
   import feathers.controls.Check;
   import feathers.core.IFeathersControl;
   import feathers.skins.IStyleProvider;
   import feathers.text.BitmapFontTextFormat;
   import feathers.textures.Scale9Textures;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import starling.display.Image;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class LogStyleFactory implements IStyleProvider
   {
      
      private static var _intsance:LogStyleFactory;
       
      
      private var checkEmpty:Texture;
      
      private var checkSelected:Texture;
      
      public const fontColor:uint = 11193599;
      
      public const monospaceFont:BitmapFont = AssetStorage.font.monospace;
      
      public const monospaceFontFormat:BitmapFontTextFormat = new BitmapFontTextFormat(monospaceFont,NaN,11193599);
      
      public const monospaceFontFormatDisabled:BitmapFontTextFormat = new BitmapFontTextFormat(monospaceFont,NaN,5592405);
      
      public const debugPanelTexture:Scale9Textures = new Scale9Textures(Texture.fromBitmapData(createDebugPanelBitmapData(),false),new Rectangle(1,1,1,1));
      
      public const thumbTexture:Texture = createThumbTexture();
      
      public function LogStyleFactory()
      {
         super();
         var _loc1_:BitmapData = new BitmapData(7,7,true,11193599 | 2281701376);
         _loc1_.fillRect(new Rectangle(1,1,5,5),0);
         checkEmpty = Texture.fromBitmapData(_loc1_);
         TextureMemoryManager.add(checkEmpty,"LogStyleFactory checkEmpty");
         _loc1_.fillRect(new Rectangle(2,2,3,3),11193599 | 4278190080);
         checkSelected = Texture.fromBitmapData(_loc1_);
         TextureMemoryManager.add(checkSelected,"LogStyleFactory checkSelected");
         TextureMemoryManager.add(debugPanelTexture.texture,"LogStyleFactory debugPanelTexture");
      }
      
      public static function get instance() : LogStyleFactory
      {
         if(_intsance == null)
         {
            _intsance = new LogStyleFactory();
         }
         return _intsance;
      }
      
      public function applyStyles(param1:IFeathersControl) : void
      {
         var _loc2_:* = null;
         if(param1 is Check)
         {
            _loc2_ = param1 as Check;
            _loc2_.defaultLabelProperties.textFormat = monospaceFontFormatDisabled;
            _loc2_.defaultSelectedLabelProperties.textFormat = monospaceFontFormat;
            _loc2_.defaultIcon = new Image(checkEmpty);
            _loc2_.defaultSelectedIcon = new Image(checkSelected);
            _loc2_.useHandCursor = true;
            _loc2_.gap = 3;
            var _loc3_:int = 5;
            _loc2_.paddingLeft = _loc3_;
            _loc2_.paddingRight = _loc3_;
         }
      }
      
      private function createDebugPanelBitmapData() : BitmapData
      {
         var _loc1_:BitmapData = new BitmapData(3,3,true,3709140997);
         return _loc1_;
      }
      
      private function createThumbTexture() : Texture
      {
         var _loc2_:BitmapData = new BitmapData(7,1,true,11193599 | 2852126720);
         var _loc1_:Texture = Texture.fromBitmapData(_loc2_,false);
         TextureMemoryManager.add(_loc1_,"LogStyleFactory thumbTexture");
         return _loc1_;
      }
   }
}
