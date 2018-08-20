package game.mediator.gui.component
{
   import idv.cjcat.signals.Signal;
   
   public class ToggleGroupComponent
   {
       
      
      private var _toggles:Vector.<ToggleComponent>;
      
      private var _selectedIndex:int = -1;
      
      public const signal_changed:Signal = new Signal();
      
      public function ToggleGroupComponent()
      {
         _toggles = new Vector.<ToggleComponent>();
         super();
      }
      
      public function get selection() : ToggleComponent
      {
         if(_selectedIndex >= 0 && _selectedIndex < _toggles.length)
         {
            return _toggles[_selectedIndex];
         }
         return null;
      }
      
      public function addToggle(param1:ToggleComponent) : void
      {
         _toggles.push(param1);
         param1.setSelectedInternal(false);
         param1.setToggleGroup(this);
      }
      
      public function selectToggle(param1:ToggleComponent) : void
      {
         var _loc2_:int = _toggles.indexOf(param1);
         if(_loc2_ != -1)
         {
            selectIndex(_loc2_);
         }
      }
      
      public function selectValue(param1:Object) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function selectIndex(param1:int) : void
      {
         if(_selectedIndex != param1)
         {
            if(_selectedIndex > -1 && _selectedIndex < _toggles.length)
            {
               _toggles[_selectedIndex].setSelectedInternal(false);
            }
            _selectedIndex = param1;
            if(_selectedIndex > -1 && _selectedIndex < _toggles.length)
            {
               _toggles[_selectedIndex].setSelectedInternal(true);
            }
            signal_changed.dispatch();
         }
      }
   }
}
