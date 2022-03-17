/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';

class ParticipationCounts extends StatelessWidget {
  const ParticipationCounts({Key? key, this.created = 0, this.votes = 0})
      : super(key: key);

  final int created;
  final int votes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$created',
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        const Text(' creadas   '),
        Text('$votes',
            style: const TextStyle(fontSize: 18, color: Colors.black)),
        const Text(' votos'),
      ],
    );
  }
}
