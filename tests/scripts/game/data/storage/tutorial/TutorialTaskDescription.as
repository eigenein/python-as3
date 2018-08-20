package game.data.storage.tutorial
{
   public class TutorialTaskDescription
   {
      
      public static const NO_PARENT:int = 0;
      
      public static const NO_SAVE_STATE:int = -1;
      
      private static const paramName:RegExp = /(%[a-zA-Z_$][a-zA-Z_$1-9.]*%)/g;
       
      
      private var initialized:Boolean;
      
      public var id:int;
      
      public var parent:int;
      
      public var saveState:int;
      
      public var tutorialStep:int;
      
      public var name:String;
      
      public var params:Array;
      
      public var unlockers:Vector.<String>;
      
      public var serverMethod:String;
      
      public var startCondition;
      
      public var view;
      
      public function TutorialTaskDescription(param1:*)
      {
         super();
         this.id = param1.id;
         if(param1.saveState is int)
         {
            this.saveState = param1.saveState;
         }
         else
         {
            this.saveState = -1;
         }
         if(param1.tutorialStep is int)
         {
            this.tutorialStep = param1.tutorialStep;
         }
         else
         {
            this.tutorialStep = -1;
         }
         this.name = param1.name;
         this.params = !!param1.params?param1.params.split(","):[];
         this.parent = param1.parent > 0?param1.parent:0;
         if(param1.unlockers && param1.unlockers is String)
         {
            this.unlockers = Vector.<String>(param1.unlockers.split(","));
         }
         this.serverMethod = param1.serverMethod;
         this.startCondition = param1.startCondition;
         this.view = param1.view;
         initialized = false;
      }
      
      public function initParams(param1:TutorialParams) : void
      {
         var _loc2_:* = undefined;
         if(initialized)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = view;
         for(var _loc3_ in view)
         {
            _loc2_ = view[_loc3_];
            if(_loc2_ is String)
            {
               view[_loc3_] = replaceParameters(param1,_loc2_);
            }
         }
         if(startCondition)
         {
            var _loc7_:int = 0;
            var _loc6_:* = startCondition;
            for(_loc3_ in startCondition)
            {
               _loc2_ = startCondition[_loc3_];
               if(_loc2_ is String)
               {
                  startCondition[_loc3_] = replaceParameters(param1,_loc2_);
               }
            }
         }
         initialized = true;
      }
      
      private function replaceParameters(param1:TutorialParams, param2:String) : String
      {
         var _loc5_:* = undefined;
         var _loc4_:Array = param2.match(paramName);
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc5_ = param1.getParameter(_loc3_.slice(1,-1));
            if(_loc5_ !== undefined)
            {
               param2 = param2.replace(_loc3_,_loc5_);
            }
         }
         return param2;
      }
   }
}
