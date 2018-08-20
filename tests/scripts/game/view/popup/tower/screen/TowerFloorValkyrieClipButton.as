package game.view.popup.tower.screen
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import starling.filters.ColorMatrixFilter;
   
   public class TowerFloorValkyrieClipButton extends ClipButton
   {
       
      
      protected var asset:RsxGuiAsset;
      
      public var tf_instant_clear:ClipLabel;
      
      public var text_bg:GuiClipScale3Image;
      
      public function TowerFloorValkyrieClipButton()
      {
         tf_instant_clear = new ClipLabel();
         text_bg = new GuiClipScale3Image(8,1);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_instant_clear.text = Translate.translate("UI_BUTTON_VALKYRIE_TF_INSTANT_CLEAR");
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(true || !hoverFilter)
               {
                  if(hoverFilter)
                  {
                     hoverFilter.dispose();
                  }
                  hoverFilter = new ColorMatrixFilter();
                  hoverFilter.adjustBrightness(0.1);
               }
               if(text_bg.graphics.filter != hoverFilter)
               {
                  if(defaultFilter != _container.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  text_bg.graphics.filter = hoverFilter;
               }
            }
            else
            {
               text_bg.graphics.filter = defaultFilter;
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
   }
}
