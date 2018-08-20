package game.view.popup.alchemy
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import game.command.rpc.refillable.AlchemyRewardValueObject;
   import game.util.NumberUtils;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipListItem;
   
   public class ClipListItemAlchemyHistory extends ClipListItem
   {
       
      
      public var tf_gems:ClipLabel;
      
      public var tf_gold:ClipLabel;
      
      public var tf_crit_value:ClipLabel;
      
      public var tf_crit_label:ClipLabel;
      
      public var crit_glow:ClipSprite;
      
      public function ClipListItemAlchemyHistory()
      {
         tf_gems = new ClipLabel();
         tf_gold = new ClipLabel(true);
         tf_crit_value = new ClipLabel();
         tf_crit_label = new ClipLabel();
         crit_glow = new ClipSprite();
         super();
      }
      
      override public function setData(param1:*) : void
      {
         var _loc2_:AlchemyRewardValueObject = param1 as AlchemyRewardValueObject;
         if(!_loc2_)
         {
            return;
         }
         tf_gems.text = String(_loc2_.costItemCount);
         tf_gold.text = NumberUtils.numberToString(_loc2_.rewardItemCount);
         var _loc3_:int = _loc2_.crit;
         if(_loc3_ > 1)
         {
            var _loc4_:* = true;
            tf_crit_label.visible = _loc4_;
            _loc4_ = _loc4_;
            tf_crit_value.visible = _loc4_;
            crit_glow.graphics.visible = _loc4_;
            tf_crit_value.text = "x" + _loc3_;
            tf_crit_label.text = Translate.translate("UI_DIALOG_ALCHEMY_CRIT");
         }
         else
         {
            _loc4_ = false;
            tf_crit_label.visible = _loc4_;
            _loc4_ = _loc4_;
            tf_crit_value.visible = _loc4_;
            crit_glow.graphics.visible = _loc4_;
         }
      }
   }
}
