package game.view.popup.alchemy
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import feathers.layout.VerticalLayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.refillable.CostButton;
   
   public class AlchemyPopupClip extends PopupClipBase
   {
       
      
      private var scrollBar:GameScrollBar;
      
      public var tf_tries_label:ClipLabel;
      
      public var tf_tries_value:ClipLabel;
      
      public var tf_history:ClipLabel;
      
      public var layout_tries:ClipLayout;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var log_item:ClipDataProvider;
      
      public var log_slider:ClipDataProvider;
      
      public var log_list:ClipListWithScroll;
      
      public var crit_wheel:AlchemyPopupCritWheelClip;
      
      public var button_single:CostButton;
      
      public var button_multi:CostButton;
      
      public var tf_roll_single:ClipLabel;
      
      public var tf_roll_multi:ClipLabel;
      
      public function AlchemyPopupClip()
      {
         scrollBar = new GameScrollBar();
         tf_tries_label = new ClipLabel(true);
         tf_tries_value = new ClipLabel(true);
         layout_tries = ClipLayout.horizontalCentered(4,tf_tries_label,tf_tries_value);
         scroll_slider_container = new ClipLayoutNone();
         crit_wheel = new AlchemyPopupCritWheelClip();
         button_single = new CostButton();
         button_multi = new CostButton();
         tf_roll_single = new ClipLabel();
         tf_roll_multi = new ClipLabel();
         super();
         log_list = new ClipListWithScroll(ClipListItemAlchemyHistory,scrollBar);
         log_item = log_list.itemClipProvider;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:int = 5;
         (log_list.list.layout as VerticalLayout).paddingTop = _loc2_;
         (log_list.list.layout as VerticalLayout).paddingBottom = _loc2_;
         scrollBar.height = scroll_slider_container.height;
         scroll_slider_container.addChild(scrollBar);
         log_list.addGradients(gradient_top.graphics,gradient_bottom.graphics);
      }
   }
}
