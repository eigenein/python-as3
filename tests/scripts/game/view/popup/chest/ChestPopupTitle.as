package game.view.popup.chest
{
   import feathers.controls.LayoutGroup;
   import feathers.display.Scale3Image;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.common.PopupTitle;
   
   public class ChestPopupTitle extends PopupTitle
   {
       
      
      protected var _minBgWidth:Number = 519;
      
      public function ChestPopupTitle(param1:String, param2:GuiClipLayoutContainer)
      {
         super(param1);
         paddingSide = 170;
         (param2.container as LayoutGroup).layout = new HorizontalLayout();
         ((param2.container as LayoutGroup).layout as HorizontalLayout).horizontalAlign = "center";
         param2.container.addChild(this);
      }
      
      override protected function createBG() : void
      {
         bg = new Scale3Image(AssetStorage.rsx.chest_graphics.getScale3Textures("header_220_199_100",199,100));
         bg.y = 0;
         addChild(bg);
      }
      
      override protected function refreshBackgroundSkin() : void
      {
         super.refreshBackgroundSkin();
         var _loc1_:Number = paddingSide * 2 + headerLabel.width;
         bg.width = _loc1_ >= _minBgWidth?_loc1_:Number(_minBgWidth);
         headerLabel.x = (bg.width - headerLabel.width) / 2;
      }
      
      public function set minBgWidth(param1:Number) : void
      {
         if(param1 != _minBgWidth)
         {
            _minBgWidth = param1;
            refreshBackgroundSkin();
         }
      }
      
      override protected function createLabel() : void
      {
         super.createLabel();
         if(headerLabel.useTextFieldTextRenderer)
         {
            headerLabel.y = 29;
         }
         else
         {
            headerLabel.y = 27;
         }
      }
   }
}
