package game.mediator.gui.popup.billing
{
   import game.view.popup.common.IPopupSideBarBlock;
   import idv.cjcat.signals.Signal;
   
   public class SideBarBlockValueObject
   {
      
      public static const PRIORITY_SPECIAL_OFFER:int = 0;
      
      public static const PRIORITY_BILLING:int = 1;
      
      public static var EMPTY:SideBarBlockValueObject = new SideBarBlockValueObject(0);
       
      
      private var priority:int = 0;
      
      private var _sideBarBlock:IPopupSideBarBlock;
      
      public const signal_initialize:Signal = new Signal(SideBarBlockValueObject);
      
      public function SideBarBlockValueObject(param1:int)
      {
         super();
         this.priority = param1;
      }
      
      public static function sort_byPriority(param1:SideBarBlockValueObject, param2:SideBarBlockValueObject) : int
      {
         return param1.priority - param2.priority;
      }
      
      public static function getMaxPriority(param1:Vector.<SideBarBlockValueObject>) : SideBarBlockValueObject
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function dispose() : void
      {
         signal_initialize.clear();
      }
      
      public function get sideBarBlock() : IPopupSideBarBlock
      {
         if(!_sideBarBlock)
         {
            signal_initialize.dispatch(this);
            if(!_sideBarBlock)
            {
               return null;
            }
         }
         var _loc1_:IPopupSideBarBlock = _sideBarBlock;
         _sideBarBlock = null;
         return _loc1_;
      }
      
      public function set sideBarBlock(param1:IPopupSideBarBlock) : void
      {
         this._sideBarBlock = param1;
      }
   }
}
