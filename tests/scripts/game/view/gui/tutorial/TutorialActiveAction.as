package game.view.gui.tutorial
{
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class TutorialActiveAction
   {
      
      private static var entryPool:Vector.<TutorialActiveAction> = new Vector.<TutorialActiveAction>();
       
      
      public var node:TutorialNode;
      
      public var button:ITutorialButton;
      
      public var key:ITutorialTargetKey;
      
      public function TutorialActiveAction()
      {
         super();
      }
      
      public static function create(param1:TutorialNode, param2:ITutorialButton, param3:ITutorialTargetKey = null) : TutorialActiveAction
      {
         var _loc4_:* = null;
         if(entryPool.length > 0)
         {
            _loc4_ = entryPool.pop();
         }
         else
         {
            _loc4_ = new TutorialActiveAction();
         }
         _loc4_.node = param1;
         _loc4_.button = param2;
         _loc4_.key = param3;
         return _loc4_;
      }
      
      public function dispose() : void
      {
         entryPool.push(this);
      }
   }
}
