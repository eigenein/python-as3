package game.view.gui.debug
{
   import feathers.controls.Check;
   import feathers.core.FeathersControl;
   import game.util.logging.Log;
   import game.util.logging.LogGroup;
   import game.util.logging.LogRecord;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class LogGroupView extends FeathersControl
   {
       
      
      public const onSelectionChanged:Signal = new Signal(LogGroupView);
      
      public const onRecordAdded:Signal = new Signal(LogRecord);
      
      protected var group:LogGroup;
      
      protected var groupCheck:Check;
      
      protected var groupIsChecking:Boolean;
      
      protected var checks:Vector.<LogCheck>;
      
      public function LogGroupView(param1:LogView, param2:LogGroup)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         groupCheck.removeEventListener("change",group_changeHandler);
         group.onLogAdded.remove(addLog);
         onSelectionChanged.clear();
         onRecordAdded.clear();
      }
      
      override public function get height() : Number
      {
         return (checks.length + 1) * 15;
      }
      
      public function get logChecks() : Vector.<LogCheck>
      {
         return checks;
      }
      
      protected function check_changeHandler(param1:Event) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function addLog(param1:Log) : void
      {
         var _loc2_:LogCheck = new LogCheck(param1,this);
         _loc2_.addEventListener("change",check_changeHandler);
         checks.push(_loc2_);
         _loc2_.y = checks.length * 15;
         this.invalidate();
         if(parent)
         {
            (parent as FeathersControl).invalidate();
         }
      }
      
      protected function group_changeHandler(param1:Event) : void
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
