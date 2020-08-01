INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(1, 'Cadastro Cliente', 'frmCadCliente', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(2, 'Cadastro Produto', 'frmCadProduto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(3, 'Forma Pagamento', 'frmCadFormaPagamento', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(4, 'Condição Pagamento', 'frmCadCondPgto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(5, 'Tabela Preco', 'frmcadTabelaPreco', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(6, 'Tabela Preco Produto', 'frmCadTabelaPrecoProduto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(7, 'Consulta de Produto', 'frmConsultaProdutos', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(8, 'Pedido de Venda', 'frmPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(9, 'Visualizar Pedido de Venda', 'frmVisualizaPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(10, 'Edição Pedido de Venda', 'frmEdicaoPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(11, 'Relatorio Venda Diária', 'frmRelVendaDiaria', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(12, 'Lançamento Nota de Entrada', 'frmLancamentoNotaEntrada', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(13, 'Cadastro Tributação Produto', 'frmCadastraTributacaoItem', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(14, 'Configurações', 'frmConfiguracoes', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(15, 'Cadastro Usuário', 'frmUsuario', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario, dt_atz) VALUES(16, 'Controle de Acesso', 'frmControleAcesso', '2020-08-01 17:34:08.422');


INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 1, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 2, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 3, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 4, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 5, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 6, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 7, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 8, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 9, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 10, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 11, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 12, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 13, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 14, true, now());
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, dt_atz) VALUES(1, 15, true, now());


INSERT INTO public.configuracao (cd_configuracao, nm_configuracao, descricao_configuracao, valor, dt_atz) VALUES(2, 'Alterar Forma/Condição na Edição Pedido de Venda', 'Se ativa, permite alterar a forma e condição de pagamento na edição do pedido de venda', 'N', now());
INSERT INTO public.configuracao (cd_configuracao, nm_configuracao, descricao_configuracao, valor, dt_atz) VALUES(1, 'Alterar Cliente na Edição Pedido de Venda', 'Se ativa, permite alterar o Cliente na edição do pedido de venda', 'N', now());
