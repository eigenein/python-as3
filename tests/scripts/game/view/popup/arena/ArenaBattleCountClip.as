package game.view.popup.arena
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ArenaBattleCountClip extends GuiClipNestedContainer
   {
       
      
      private var _maxValue:int;
      
      public var tf_header:ClipLabel;
      
      public var battle_count_max:ArenaBattleCountNumberClipMaxed;
      
      public var battle_count_refillable:ArenaBattleCountNumberClipRefillable;
      
      public function ArenaBattleCountClip()
      {
         tf_header = new ClipLabel();
         battle_count_max = new ArenaBattleCountNumberClipMaxed();
         battle_count_refillable = new ArenaBattleCountNumberClipRefillable();
         super();
      }
      
      public function setValues(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = true;
         battle_count_max.graphics.visible = !_loc3_;
         battle_count_refillable.graphics.visible = _loc3_;
         if(!_loc3_)
         {
            battle_count_max.tf_current_battles.text = param1.toString();
            battle_count_max.tf_max_battles.text = "/" + param2.toString();
         }
         else
         {
            battle_count_refillable.tf_current_battles.text = param1.toString();
            battle_count_refillable.tf_max_battles.text = "/" + param2.toString();
         }
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function set maxValue(param1:int) : void
      {
         if(_maxValue == param1)
         {
            return;
         }
         _maxValue = param1;
      }
   }
}
