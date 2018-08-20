package game.view.popup.arena.rules
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArenaRulesPlaceRewardClip extends GuiClipNestedContainer
   {
       
      
      public var tf_place:ClipLabel;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var tf_layout:ClipLayout;
      
      public var reward_item_1:ArenaRulesRewardItem;
      
      public var reward_item_2:ArenaRulesRewardItem;
      
      public var reward_item_3:ArenaRulesRewardItem;
      
      public var reward_item_4:ArenaRulesRewardItem;
      
      public var reward_item_5:ArenaRulesRewardItem;
      
      public var reward_items:Vector.<ArenaRulesRewardItem>;
      
      public var reward_layout:ClipLayout;
      
      public function ArenaRulesPlaceRewardClip()
      {
         tf_place = new ClipLabel();
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_layout = ClipLayout.horizontalMiddleCentered(0,tf_place);
         reward_item_1 = new ArenaRulesRewardItem();
         reward_item_2 = new ArenaRulesRewardItem();
         reward_item_3 = new ArenaRulesRewardItem();
         reward_item_4 = new ArenaRulesRewardItem();
         reward_item_5 = new ArenaRulesRewardItem();
         reward_items = new <ArenaRulesRewardItem>[reward_item_1,reward_item_2,reward_item_3,reward_item_4,reward_item_5];
         reward_layout = ClipLayout.horizontalCentered(8,reward_item_1,reward_item_2,reward_item_3,reward_item_4,reward_item_5);
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 5;
         _loc2_ = 1;
         while(_loc2_ <= _loc1_)
         {
            (this["reward_item_" + _loc2_] as ArenaRulesRewardItem).dispose();
            _loc2_++;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_place.height = NaN;
      }
   }
}
