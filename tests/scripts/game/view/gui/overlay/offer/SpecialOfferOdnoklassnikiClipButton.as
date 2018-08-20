package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipLabel;
   import starling.display.Sprite;
   import starling.filters.ColorMatrixFilter;
   
   public class SpecialOfferOdnoklassnikiClipButton extends SideBarButton
   {
       
      
      public var icon_tmp:GuiAnimation;
      
      public var tf_single_line:ClipLabel;
      
      private var filterContainer:Sprite;
      
      public function SpecialOfferOdnoklassnikiClipButton()
      {
         icon_tmp = new GuiAnimation();
         tf_single_line = new ClipLabel();
         filterContainer = new Sprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_single_line.text = Translate.translate("UI_BUNDLE_LINE_0");
         filterContainer.addChild(icon_tmp.graphics);
         filterContainer.addChild(tf_single_line.graphics);
         layout_hitArea.addChild(filterContainer);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            if(filterContainer)
            {
               filterContainer.filter = _loc3_;
            }
         }
         else if(filterContainer)
         {
            if(filterContainer.filter)
            {
               filterContainer.filter.dispose();
            }
            filterContainer.filter = null;
         }
      }
   }
}
