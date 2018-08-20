package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SpecialQuestListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_go:ClipButtonLabeled;
      
      public var button_finish:ClipButtonLabeledAnimated;
      
      public var reward_item_1:InventoryItemRenderer;
      
      public var reward_item_2:InventoryItemRenderer;
      
      public var slot1:GuiClipScale9Image;
      
      public var slot2:GuiClipScale9Image;
      
      public var reward_items:Vector.<InventoryItemRenderer>;
      
      public var slots:Vector.<GuiClipScale9Image>;
      
      public var layout_reward:ClipLayout;
      
      public var label_questTask:SpecialClipLabel;
      
      public var layout_questTask:ClipLayout;
      
      public function SpecialQuestListItemRendererClip()
      {
         reward_item_1 = new InventoryItemRenderer();
         reward_item_2 = new InventoryItemRenderer();
         slot1 = new GuiClipScale9Image();
         slot2 = new GuiClipScale9Image();
         reward_items = new Vector.<InventoryItemRenderer>();
         slots = new Vector.<GuiClipScale9Image>();
         layout_reward = ClipLayout.horizontalMiddleLeft(4);
         label_questTask = new SpecialClipLabel();
         layout_questTask = ClipLayout.horizontalMiddleCentered(0,label_questTask);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         _loc2_ = 1;
         while(_loc2_ <= 2)
         {
            reward_items.push(this["reward_item_" + _loc2_] as InventoryItemRenderer);
            slots.push(this["slot" + _loc2_] as GuiClipScale9Image);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         reward_item_1.dispose();
         reward_item_2.dispose();
      }
   }
}
