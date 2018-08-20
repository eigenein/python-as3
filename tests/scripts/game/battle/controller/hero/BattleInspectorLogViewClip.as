package game.battle.controller.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class BattleInspectorLogViewClip extends GuiClipNestedContainer
   {
       
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const scrollContainer:GameScrolledList = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
      
      public const button_hide:ClipButtonLabeledUnderlined = new ClipButtonLabeledUnderlined();
      
      public const button_copy:ClipButtonLabeledUnderlined = new ClipButtonLabeledUnderlined();
      
      public function BattleInspectorLogViewClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:int = 5;
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.useVirtualLayout = true;
         scrollContainer.itemRendererType = BattleInspectorLogViewClipItemRenderer;
         scrollContainer.layout = _loc3_;
      }
   }
}

import feathers.controls.Label;
import game.view.gui.components.GameLabel;
import game.view.gui.components.list.ListItemRenderer;

class BattleInspectorLogViewClipItemRenderer extends ListItemRenderer
{
    
   
   private var label:Label;
   
   function BattleInspectorLogViewClipItemRenderer()
   {
      super();
   }
   
   override protected function initialize() : void
   {
      super.initialize();
      label = GameLabel.special14();
      addChild(label);
   }
   
   override protected function commitData() : void
   {
      label.text = String(data);
      if(label.stage)
      {
         label.flatten(true);
      }
      if(data != null)
      {
         label.alpha = data.alpha;
      }
   }
}
