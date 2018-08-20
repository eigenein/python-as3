package game.view.popup.hero.slot
{
   import com.progrestar.framework.ares.core.Node;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.SpecialClipLabel;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClipListItemBattleStat extends ClipListItem
   {
       
      
      private var prefix:String;
      
      public var stat_name:ClipLabel;
      
      public function ClipListItemBattleStat()
      {
         prefix = ColorUtils.hexToRGBFormat(16777215);
         stat_name = new SpecialClipLabel();
         super();
      }
      
      override public function setData(param1:*) : void
      {
         var _loc2_:BattleStatValueObject = param1 as BattleStatValueObject;
         if(!_loc2_)
         {
            return;
         }
         stat_name.text = _loc2_.name + prefix + " +" + _loc2_.value;
         stat_name.validate();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         stat_name.maxHeight = Infinity;
      }
   }
}
