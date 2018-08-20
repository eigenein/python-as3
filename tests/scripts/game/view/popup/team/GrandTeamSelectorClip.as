package game.view.popup.team
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.grand.popup.GrandSelectorButton;
   import org.osflash.signals.Signal;
   
   public class GrandTeamSelectorClip extends GuiClipNestedContainer
   {
       
      
      private var _buttonPositions:Vector.<Number>;
      
      private var _buttons:Vector.<GrandSelectorButton>;
      
      private var _selectedTeamIndex:int;
      
      public const button_team1:GrandSelectorButton = new GrandSelectorButton();
      
      public const button_team2:GrandSelectorButton = new GrandSelectorButton();
      
      public const button_team3:GrandSelectorButton = new GrandSelectorButton();
      
      public const signal_changeButtonIndices:Signal = new Signal(int,int);
      
      public function GrandTeamSelectorClip()
      {
         _buttonPositions = new Vector.<Number>();
         _buttons = new Vector.<GrandSelectorButton>();
         super();
      }
      
      public function set selectedTeamIndex(param1:int) : void
      {
         _selectedTeamIndex = param1;
         updateSelection();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         _buttonPositions.push(button_team1.graphics.y);
         _buttonPositions.push(button_team2.graphics.y);
         _buttonPositions.push(button_team3.graphics.y);
         _buttons.push(button_team1);
         _buttons.push(button_team2);
         _buttons.push(button_team3);
         button_team1.setButtonPositions(this,_buttonPositions,_buttons,0);
         button_team2.setButtonPositions(this,_buttonPositions,_buttons,1);
         button_team3.setButtonPositions(this,_buttonPositions,_buttons,2);
      }
      
      public function getButtonByIndex(param1:int) : GrandSelectorButton
      {
         return _buttons[param1];
      }
      
      public function changeButtonIndices(param1:int, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:GrandSelectorButton = _buttons[param1];
         if(param2 > param1)
         {
            _loc4_ = param1;
            while(_loc4_ < param2)
            {
               _buttons[_loc4_] = _buttons[_loc4_ + 1];
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = param1;
            while(_loc4_ > param2)
            {
               _buttons[_loc4_] = _buttons[_loc4_ - 1];
               _loc4_--;
            }
         }
         _buttons[param2] = _loc3_;
         _loc4_ = 0;
         while(_loc4_ < _buttons.length)
         {
            _buttons[_loc4_].snapIndex = _loc4_;
            _loc4_++;
         }
         updateSelection();
         signal_changeButtonIndices.dispatch(param1,param2);
      }
      
      protected function updateSelection() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
