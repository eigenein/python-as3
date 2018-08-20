package game.view.gui.tutorial
{
   import avmplus.getQualifiedClassName;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   import org.osflash.signals.Signal;
   import starling.display.DisplayObject;
   
   public class TutorialActionsHolder
   {
      
      private static var entryPool:Vector.<TutorialActionsHolder> = new Vector.<TutorialActionsHolder>();
       
      
      public const actions:Vector.<TutorialActiveAction> = new Vector.<TutorialActiveAction>();
      
      private var _signal_onDispose:Signal;
      
      private var displayObject:DisplayObject;
      
      public function TutorialActionsHolder()
      {
         super();
      }
      
      public static function create(param1:DisplayObject) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(entryPool.length > 0)
         {
            _loc2_ = entryPool.pop();
         }
         else
         {
            _loc2_ = new TutorialActionsHolder();
         }
         _loc2_.displayObject = param1;
         return _loc2_;
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get isActive() : Boolean
      {
         return displayObject && displayObject.stage && displayObject.visible;
      }
      
      public function get signal_onDispose() : Signal
      {
         if(!_signal_onDispose)
         {
            _signal_onDispose = new Signal();
         }
         return _signal_onDispose;
      }
      
      public function addCloseButton(param1:ITutorialButton) : void
      {
         if(param1 == null)
         {
            trace(getQualifiedClassName(this),"addButton: invalid tutorial button");
         }
         actions.push(TutorialActiveAction.create(TutorialNavigator.ACTION_CLOSE,param1));
      }
      
      public function addButton(param1:TutorialNode, param2:ITutorialButton) : void
      {
         if(param1 == null || param2 == null)
         {
            trace(getQualifiedClassName(this),"addButton: invalid tutorial button; target:",!!param1?param1.name:null,"button:",param2);
         }
         actions.push(TutorialActiveAction.create(param1,param2));
      }
      
      public function addButtonWithKey(param1:TutorialNode, param2:ITutorialButton, param3:ITutorialTargetKey) : void
      {
         if(param1 == null || param2 == null)
         {
            trace(getQualifiedClassName(this),"addButtonWithKey: invalid tutorial button; target:",!!param1?param1.name:null,"button:",param2);
         }
         actions.push(TutorialActiveAction.create(param1,param2,param3));
      }
   }
}
