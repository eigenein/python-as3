package game.view.popup.quest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class QuestRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var glow:ClipSprite;
      
      public var list_item_1:InventoryItemRenderer;
      
      public var list_item_2:InventoryItemRenderer;
      
      public var list_item_3:InventoryItemRenderer;
      
      public var list_item_4:InventoryItemRenderer;
      
      public var list_item:Vector.<InventoryItemRenderer>;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_item_list:ClipLayout;
      
      public function QuestRewardPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_reward = new ClipLabel();
         glow = new ClipSprite();
         list_item_1 = new InventoryItemRenderer();
         list_item_2 = new InventoryItemRenderer();
         list_item_3 = new InventoryItemRenderer();
         list_item_4 = new InventoryItemRenderer();
         list_item = new Vector.<InventoryItemRenderer>();
         bg = new GuiClipScale9Image();
         layout_item_list = ClipLayout.horizontalMiddleCentered(0,list_item_1,list_item_2,list_item_3,list_item_4);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         var _loc3_:int = list_item.length;
         if(_loc3_ > 0)
         {
            layout_item_list.removeChildren(0,-1,true);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               layout_item_list.addChild(list_item[_loc2_].graphics);
               _loc2_++;
            }
         }
      }
      
      public function setReward(param1:Vector.<InventoryItem>) : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = 0;
         var _loc2_:* = null;
         var _loc6_:int = list_item.length;
         var _loc4_:int = param1.length;
         if(_loc6_ == 0)
         {
            _loc3_ = 4;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = this["list_item_" + (_loc5_ + 1)];
               if(_loc2_)
               {
                  if(_loc5_ < _loc4_)
                  {
                     _loc2_.setData(param1[_loc5_]);
                  }
                  else
                  {
                     _loc2_.graphics.visible = false;
                  }
               }
               _loc5_++;
            }
         }
         else
         {
            _loc3_ = Math.min(_loc6_,_loc4_);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               list_item[_loc5_].setData(param1[_loc5_]);
               list_item[_loc5_].graphics.visible = true;
               _loc5_++;
            }
            _loc5_ = _loc3_;
            while(_loc5_ < _loc6_)
            {
               list_item[_loc5_].graphics.visible = false;
               _loc5_++;
            }
         }
      }
   }
}
