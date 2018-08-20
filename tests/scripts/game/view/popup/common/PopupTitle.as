package game.view.popup.common
{
   import feathers.controls.LayoutGroup;
   import feathers.display.Scale3Image;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.util.FontUtils;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class PopupTitle extends LayoutGroup
   {
       
      
      protected var bg:Scale3Image;
      
      protected var headerLabel:GameLabel;
      
      protected var paddingSide:int = 108;
      
      protected var _text:String;
      
      public function PopupTitle(param1:String)
      {
         super();
         this._text = param1;
      }
      
      public static function create(param1:String, param2:GuiClipLayoutContainer) : PopupTitle
      {
         var _loc3_:PopupTitle = new PopupTitle(param1);
         (param2.container as LayoutGroup).layout = new HorizontalLayout();
         ((param2.container as LayoutGroup).layout as HorizontalLayout).horizontalAlign = "center";
         param2.container.addChild(_loc3_);
         return _loc3_;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
         headerLabel.text = param1;
         headerLabel.validate();
         refreshBackgroundSkin();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createBG();
         createLabel();
      }
      
      protected function createBG() : void
      {
         bg = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("header_178_178_2",178,2));
         bg.y = 0;
         addChild(bg);
      }
      
      protected function createLabel() : void
      {
         headerLabel = GameLabel.special24();
         headerLabel.y = 14;
         addChild(headerLabel);
         headerLabel.text = _text;
         headerLabel.validate();
         if(headerLabel.useTextFieldTextRenderer)
         {
            headerLabel.y = headerLabel.y + (FontUtils.getGameFontBaselineByLabel(headerLabel) - headerLabel.baseline + 1);
         }
      }
      
      override protected function refreshBackgroundSkin() : void
      {
         super.refreshBackgroundSkin();
         bg.width = paddingSide * 2 + headerLabel.width;
         headerLabel.x = paddingSide;
      }
   }
}
