package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.quest.QuestRewardItemRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class NYTreeDecorateRendederClip extends GuiClipNestedContainer
   {
       
      
      private var data:NY2018TreeDecorateAction;
      
      private var _multiplier:int = 1;
      
      public var tf_title:ClipLabel;
      
      public var reward:InventoryItemRenderer;
      
      public var cost:QuestRewardItemRenderer;
      
      public var btn_decorate:ClipButtonLabeled;
      
      public var signal_decorate:Signal;
      
      public function NYTreeDecorateRendederClip()
      {
         tf_title = new ClipLabel();
         reward = new InventoryItemRenderer();
         cost = new QuestRewardItemRenderer();
         btn_decorate = new ClipButtonLabeled();
         signal_decorate = new Signal(NY2018TreeDecorateAction,int);
         super();
      }
      
      public function get multiplier() : int
      {
         return _multiplier;
      }
      
      public function set multiplier(param1:int) : void
      {
         if(_multiplier == param1)
         {
            return;
         }
         _multiplier = param1;
         updateState();
      }
      
      public function get titleLabel() : String
      {
         return Translate.translateArgs("UI_DIALOG_NY_TREE_UPGRADE_REWARD",data.reward.outputDisplayFirst.amount * multiplier);
      }
      
      public function get buttonLabel() : String
      {
         return Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_BUTTON_LABEL");
      }
      
      public function setData(param1:NY2018TreeDecorateAction) : void
      {
         this.data = param1;
         updateState();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         btn_decorate.label = buttonLabel;
         btn_decorate.signal_click.add(handler_decotare);
      }
      
      protected function updateState() : void
      {
         tf_title.text = titleLabel;
         cost.data = new InventoryItem(data.cost.outputDisplayFirst.item,data.cost.outputDisplayFirst.amount * multiplier);
         reward.setData(new InventoryItem(data.reward.outputDisplayFirst.item,data.reward.outputDisplayFirst.amount * multiplier));
      }
      
      private function handler_decotare() : void
      {
         signal_decorate.dispatch(data,multiplier);
      }
   }
}
