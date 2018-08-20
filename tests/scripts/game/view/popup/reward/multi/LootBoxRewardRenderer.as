package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.inventory.LootBoxRewardValueObject;
   import game.mediator.gui.component.RewardValueObject;
   
   public class LootBoxRewardRenderer extends MultiRewardRenderer
   {
       
      
      public function LootBoxRewardRenderer()
      {
         super();
      }
      
      override protected function setCaption(param1:RewardValueObject) : void
      {
         if(!clip)
         {
            return;
         }
         var _loc2_:LootBoxRewardValueObject = param1 as LootBoxRewardValueObject;
         clip.tf_caption.text = _loc2_.item.name + " " + _loc2_.index;
         clip.layout_item_list.list.dataProvider = new ListCollection(_loc2_.reward.outputDisplay);
         if(_loc2_.reward.isEmpty)
         {
            clip.tf_empty.visible = true;
            clip.tf_empty.text = Translate.translate("UI_POPUP_MAIL_REWARD_EMPTY");
         }
         else
         {
            clip.tf_empty.visible = false;
         }
      }
   }
}
