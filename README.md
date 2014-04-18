```erlang
$ erl                                                                                                                                                                      [22:59:08]
Erlang R16B02 (erts-5.10.3) [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V5.10.3  (abort with ^G)
1>
1> Parts = 10.
10
2>  Ring = lists:foldl(fun (R1, R2) -> chash:merge_rings(R1, R2) end, chash:fresh(Parts, node_1), [chash:fresh(Parts, node_2), chash:fresh(Parts, node_3)]).
{10,
 [{0,node_3},
  {146150163733090291820368483271628301965593254297,node_1},
  {292300327466180583640736966543256603931186508594,node_3},
  {438450491199270875461105449814884905896779762891,node_1},
  {584600654932361167281473933086513207862373017188,node_3},
  {730750818665451459101842416358141509827966271485,node_3},
  {876900982398541750922210899629769811793559525782,node_3},
  {1023051146131632042742579382901398113759152780079,node_3},
  {1169201309864722334562947866173026415724746034376,node_2},
  {1315351473597812626383316349444654717690339288673,node_3},
  {1461501637330902918203684832716283019655932542970,node_3}]}
3>
3> Hash = chashbin:create(Ring).
{chashbin,10,
          <<0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,25,153,153,
            153,...>>,
          {node_1,node_2,node_3}}
4>
4> Data2Node =
4>     fun (Data) ->
4>         SHA1 = crypto:sha(term_to_binary(Data)),
4>         Index = chashbin:responsible_index(SHA1, Hash),
4>         Node = chash:lookup(Index, Ring),
4>         Node
4>     end.
#Fun<erl_eval.6.80484245>
5>
5> Data2Node(123).
node_1
6>
6> Data2Node(abcdefg).
node_1
7>
7> Data2Node(1).
node_1
8>
8> Data2Node(<<"foo-bar-baz">>).
node_3
9>
9>
9> Data2Node(<<"">>).
node_1
10>
10> Data2Node(987).
node_3
10>
11> Data2Node(12345).
node_2
11>
```
