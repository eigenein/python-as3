package game.view.gui.tutorial
{
   import flash.utils.Dictionary;
   
   public class TutorialStateMachineResolver
   {
       
      
      private var nodesMap:Dictionary;
      
      private var nodes:Vector.<TutorialNode>;
      
      private var route:Vector.<TutorialNode>;
      
      private var currentRouteParents:Vector.<TutorialNode>;
      
      public function TutorialStateMachineResolver()
      {
         nodesMap = new Dictionary();
         nodes = new Vector.<TutorialNode>();
         route = new Vector.<TutorialNode>();
         currentRouteParents = new Vector.<TutorialNode>();
         super();
      }
      
      public function init() : void
      {
         var _loc2_:int = nodes.length;
         var _loc4_:int = 0;
         var _loc3_:* = nodesMap;
         for(var _loc1_ in nodesMap)
         {
            _loc2_++;
            nodes[_loc2_] = _loc1_;
         }
         currentRouteParents.length = TutorialNode.maxId;
      }
      
      public function getNodeByName(param1:String) : TutorialNode
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addLinks(param1:TutorialNode, ... rest) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addForwardLinks(param1:TutorialNode, ... rest) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function findNextNode(param1:TutorialNode, param2:TutorialNode) : TutorialNode
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function buildBackwardRoute(param1:TutorialNode, param2:TutorialNode, param3:TutorialNode) : void
      {
         route[0] = param2;
         var _loc4_:int = 1;
         param2 = param3;
         while(param2 != param1)
         {
            _loc4_++;
            route[_loc4_] = param2;
            param2 = currentRouteParents[param2.id];
         }
         _loc4_++;
         route[_loc4_] = param1;
         route.length = _loc4_;
      }
   }
}
